extends Area2D

var move_range = 4
var moving = false
var move_time = .5

var face_to

onready var anim = $AnimationPlayer

func _ready():
	face_to = scale.x
	anim.play("idle")
	
func start_move(var pos:Vector2):
	if not moving:
		moving = true
		anim.play("walk")
		var offset_x := pos.x - position.x 
		var offset_y := pos.y - position.y 
		
		if  offset_x != 0:
			scale.x = face_to if offset_x > 0 else -face_to
		
		var tween := create_tween()
		
		if offset_x == 0 or offset_y == 0:
			tween.tween_property(self, "position", pos, move_time)
		else:
			var offset = offset_x * Vector2.RIGHT if offset_x < offset_y else offset_y * Vector2.DOWN
			var length := abs(offset_x) + abs(offset_y)
			var time1 = abs(offset_x) / length if offset_x < offset_y else abs(offset_y) / length
			
			tween.tween_property(self, "position", position + offset, time1 * move_time)
			tween.tween_property(self, "position", pos, (1 - time1) * move_time)
		tween.tween_callback(self, "arrived")

func arrived():
	moving = false
	anim.play("idle")
