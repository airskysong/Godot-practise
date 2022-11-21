extends "res://Asset/Scripts/Enemy.gd"

export var max_speed = 300
export var acceleration_time = 0.5

var acceleration = max_speed / acceleration_time

var velocity = Vector2.ZERO


func _process(delta):
	velocity.x = move_toward(velocity.x, max_speed * current_dir, delta * acceleration)
	pass

func _physics_process(delta):

	var was_on_wall = is_on_wall()
	move_and_slide(velocity, Vector2.UP)
	if not was_on_wall and is_on_wall():
		 velocity.x = 0
		 current_dir = -current_dir
		 sprite.flip_h = current_dir > 0
	
	velocity.y += gravity * delta
	if is_on_floor():
		velocity.y = 0


func dead():
	stop_check()
	hurt()




