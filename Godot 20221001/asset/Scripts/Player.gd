extends RigidBody2D

var interval = 0.3
var timer = 0
var jump_force = 450

func _ready():
	connect("body_entered", self, "on_body_entered")

func _process(delta):
	timer += delta;
	if Input.is_mouse_button_pressed(1) && timer >= interval:
		timer=0
		linear_velocity = Vector2.UP * jump_force
		angular_velocity = -3
		AudioManager.play("sfx_wing")
	if(rotation_degrees < -30):
		rotation_degrees = -30
		angular_velocity = 0
	if(linear_velocity.y > 0.0):
		angular_velocity = 1.5
	if(rotation_degrees > 90):
		rotation_degrees = 90

func on_body_entered(_body):
	if(_body is StaticBody2D):
		AudioManager.play("sfx_die")
		call_deferred("set_process", false)
#		set_physics_process(false)
		call_deferred("set_contact_monitor", false)
#		set_contact_monitor(false)
		$AnimationPlayer.play("die")
		GameData.update_record()
		get_tree().call_group("GAME_STATE", "on_game_over")

