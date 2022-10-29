extends Area2D

var radius = 30
var can_move = true

func _input(event):
	if event != null and event is InputEventScreenTouch:
#		if (event.position - position).length() > radius:
		print(event.position)
		startTween(event.position)

func startTween(var endPos:Vector2):
	if can_move:
		$Tween.interpolate_property(self, "position", position,
		endPos, 0.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		$Tween.start()
		can_move = false
		



func _on_Tween_tween_all_completed():
	can_move = true
	$Effect/Particles2D.restart()
