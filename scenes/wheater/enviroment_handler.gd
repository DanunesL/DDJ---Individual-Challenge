extends StaticBody2D

var current_weather = "none"

func _ready():
	$Timer.start()
	update_weather()

func update_weather():
	if current_weather == "none":
		self.visible = false
		$Rain.visible = false
		$Fog.visible = false
	elif current_weather == "rain":
		self.visible = true
		$Rain.visible = true
		$Fog.visible = false
		$CanvasModulate.color = Color(0.3, 0.3, 0.3)

	elif current_weather == "fog":
		self.visible = true
		$Rain.visible = false
		$Fog.visible = true
		$CanvasModulate.color = Color(1.0, 1.0, 1.0, 0.3) 


func _on_timer_timeout():
	# Randomly choose between "rain", "fog", or "none"
	current_weather = "rain" if randi_range(0, 2) == 0 else "fog" if randi_range(0, 1) == 0 else "none"
	Global.weather = current_weather
	update_weather()
	
	# Adjust the timer wait time based on the weather
	if current_weather == "rain":
		$Timer.wait_time = randf_range(15, 40)
	elif current_weather == "fog":
		$Timer.wait_time = randf_range(30, 60)
	else:
		$Timer.wait_time = randf_range(20, 50)
	
	$Timer.start()
	
func _input(event):
	if event.is_action_pressed("ChangeW"):
		_on_button_pressed()

func _on_button_pressed():
	if current_weather == "none":
		current_weather = "rain"
	elif current_weather == "rain":
		current_weather = "fog"
	else:
		current_weather = "none"
	
	Global.weather = current_weather
	update_weather()
