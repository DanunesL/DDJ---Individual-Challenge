extends Area2D

@onready var collider = $CollisionShape2D
@onready var timer = $DisableTimer

signal hurt(damage)

func _on_area_entered(area):
	if area.is_in_group("hitboxes"):
		var damage = area.damage
		hurt.emit(damage)
		
		collider.call_deferred("set", "disabled", true)
		timer.start()


func _on_disable_timer_timeout():
	collider.call_deferred("set", "disabled", false)
