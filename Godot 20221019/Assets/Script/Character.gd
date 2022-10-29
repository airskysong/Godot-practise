extends Area2D

export(float) var move_speed  = 1.0
var tile_size = 64
var facing = "right"
var can_move = true

var moves = {"up":Vector2(0, -1), "down":Vector2(0, 1),
"left":Vector2(-1, 0), "right":Vector2(1, 0)}
onready var rayCasts = {"up":$RayCast2DUp, "down":$RayCast2DDown,
"left":$RayCast2DLeft, "right":$RayCast2DRight}

func move(dir):
	facing = dir
	$AnimationPlayer.playback_speed = move_speed / 0.3
	var hit = rayCasts[facing].get_collider()
	if hit != null:
		return 
	
	can_move = false
	$Tween.interpolate_property(self, "position",
	position, position + moves[facing] * tile_size,
	0.3 / move_speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.start()
	$AnimationPlayer.play(facing)
	return true
	
func _on_Tween_tween_all_completed():
	can_move = true
