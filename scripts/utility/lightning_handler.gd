extends Node2D

@export var thunder_interval: float = 2.0  # Intervalo em segundos entre cada um
@export var strike_duration: float = 1.0  # duração do strike

var is_striking: bool = false

@onready var player = get_node_or_null("../Player")

func _ready():
	var timer = $TimeStrike
	timer.wait_time = thunder_interval
	timer.start()
	hide_thunder_and_hitbox()

func _process(delta):
	if player and not is_striking:
		follow_Player()

func follow_Player():
	if player:
		var offset_x = randf_range(-50, 50) 
		var offset_y = randf_range(-50, 50)
		global_position = player.global_position + Vector2(offset_x, offset_y)

func hide_thunder_and_hitbox():
	$Lightning.visible = false
	$Circle.visible = false
	$Circle2.visible = false
	$Circle3.visible = false
	deactivate_hitbox()
	thunder_interval = randf_range(2.0, 5.0)
	var timer = $TimeStrike
	timer.wait_time = thunder_interval
	timer.start()
	
func show_thunder_and_hitbox():
	warning_circle()
	await get_tree().create_timer(1.5).timeout 
	$Lightning.visible = true
	activate_hitbox()
	var timer = $TimeStrike
	timer.wait_time = strike_duration
	timer.start()

func _on_timer_timeout() -> void:
	if $Lightning.visible:
		is_striking = false
		hide_thunder_and_hitbox()
	elif not $Lightning.visible and Global.weather == "rain":
		is_striking = true
		show_thunder_and_hitbox()
		
func warning_circle():
	$Circle.visible = true
	await get_tree().create_timer(0.5).timeout 
	
	$Circle.visible = false
	$Circle2.visible = true
	await get_tree().create_timer(0.5).timeout
	
	$Circle2.visible = false
	$Circle3.visible = true
	await get_tree().create_timer(0.5).timeout
	
	$Circle3.visible = false

func deactivate_hitbox():
	if $Hitbox and $Hitbox/CollisionShape2D:
		$Hitbox.set_monitorable(false)  # Disable Area2D signals (optional)
		$Hitbox.set_monitoring(false)  # Disable collision monitoring
		$Hitbox/CollisionShape2D.disabled = true  # Disable the collision shape

func activate_hitbox():
	if $Hitbox and $Hitbox/CollisionShape2D:
		$Hitbox.set_monitorable(true)  # Enable Area2D signals (optional)
		$Hitbox.set_monitoring(true)  # Enable collision monitoring
		$Hitbox/CollisionShape2D.disabled = false  # Enable the collision shape
