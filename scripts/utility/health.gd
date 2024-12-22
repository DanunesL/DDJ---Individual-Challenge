extends Node

@export var hp : int
@export var max_hp : int

@export var health_bar : ProgressBar

signal died

func take_damage(damage):
	hp = clamp(hp - damage, 0, max_hp)
	
	if health_bar != null:
		health_bar.value = hp
	
	if hp <= 0:
		died.emit()
