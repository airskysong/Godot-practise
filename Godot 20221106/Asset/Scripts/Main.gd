extends Node2D

onready var joystick = $JoyStick
onready var player = $Player

func _ready():
	joystick.hide()

func _input(event):
	if event is InputEventScreenTouch and event.is_pressed():
		joystick.show()
		joystick.position = event.position
	if event is InputEventScreenTouch and !event.is_pressed():
		joystick.hide()

func _process(delta):
	if(joystick.visible):
		player.move_and_slide(joystick.get_joystick_input() * 100)
