extends KinematicBody

export var moveSpeed = 14
export var fall_acceleration = 75
export var jump_impulse = 20
export var bounce_impulse = 16

signal hit
var velocity = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var direction = Vector3.ZERO
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if is_on_floor() and Input.is_action_pressed("jump"):
		velocity.y += jump_impulse
		
	#归一化处理
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.look_at(translation + direction, Vector3.UP)
	velocity.x = direction.x * moveSpeed
	velocity.y -= fall_acceleration * delta
	velocity.z = direction.z * moveSpeed
	velocity = move_and_slide(velocity, Vector3.UP)
	for index in range(get_slide_count()):
		# We check every collision that occurred this frame.
		var collision = get_slide_collision(index)
		# If we collide with a monster...
		if collision.collider.is_in_group("mob"):
			var mob = collision.collider
			# ...we check that we are hitting it from above.
			if Vector3.UP.dot(collision.normal) > 0.1:
				# If so, we squash it and bounce.
				mob.squash()
				velocity.y = bounce_impulse

func die():
	emit_signal("hit")
	queue_free()

func _on_MobDetector_body_entered(_body):
	die()
