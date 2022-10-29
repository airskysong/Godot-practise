extends "res://Assets/Script/Character.gd"

signal player_moved

# warning-ignore:unused_argument
func _physics_process(delta):
	if can_move:
		for c in moves.keys():
			if Input.is_action_pressed(c):
				if move(c):
					emit_signal("player_moved")
	
	if Input.is_key_pressed(KEY_SPACE):
		print("player die")
		hit()	


func _on_Player_area_entered(area):
	if area.is_in_group("item"):
		area.picked_up()
	if area.is_in_group("enemy"):
		hit()

func hit():
	# close update
	self.set_physics_process(false)
	$CollisionShape2D.set_deferred("disable", true)
#	self.call_deferred("set_physics_process", "false")
	$AnimationPlayer.play("die")
	$Tween.stop_all()
	yield($AnimationPlayer,"animation_finished")
	get_tree().call_group("game_state", "game_over")
	hide()


