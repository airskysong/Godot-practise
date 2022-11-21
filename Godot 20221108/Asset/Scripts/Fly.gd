extends "res://Asset/Scripts/Enemy.gd"

export var chasse_distance = 128
export var max_speed = 500
export var accel_time = 0.8

var acceleration = max_speed / accel_time

onready var detect_area := $DetectArea
onready var timer := $Timer

var target
var chassing = false
var dir := Vector2.ZERO
var velocity := Vector2.ZERO
var current_speed := .0
var original_pos
var current_state = state.GUARD

var ready_time = 0.8
var is_aim := false

enum state{
	STAY=-1,
	CHASSE=0,
	GUARD=1,
	AIM=2
}


func _ready():
	original_pos = global_position
	
func _physics_process(delta):
	match current_state:
		state.STAY:
			stay(delta)
		state.GUARD:
			guard()
		state.CHASSE:
			chasse(delta)
		state.AIM:
			aim()
			
func guard():
	var check =  detect_area.get_overlapping_bodies()

	if check:
		sprite.flip_h = (check[0].position - global_position).x > 0
		current_state = state.AIM
		anim.playback_speed = 2
		is_aim = false

func stay(var delta):
	var to = original_pos
	move_to(to, delta)
	if (global_position - original_pos).length() < 32:
		current_state = state.GUARD
	
func chasse(var delta):
	move_to(target, delta)
	if (global_position - target).length() < 32:
		current_state = state.STAY
		anim.playback_speed = 1
		current_speed = 0

func aim():
	var check =  detect_area.get_overlapping_bodies()

	if check:
		target = check[0].global_position
		if not is_aim:
			timer.start(ready_time)
			is_aim = true
			yield(timer,"timeout")
			current_state = state.CHASSE
	



func move_to(var to : Vector2, var delta):
	dir = (to - global_position).normalized()
	current_speed = move_toward(current_speed, max_speed, delta * acceleration)
	velocity = current_speed * dir
	move_and_slide(velocity)
	sprite.flip_h = velocity.x > 0



func dead():
	anim.playback_speed = 1
	stop_check()
	hurt()
