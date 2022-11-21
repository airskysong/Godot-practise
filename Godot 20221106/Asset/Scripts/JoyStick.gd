extends Sprite

var radius = 64
var dragging = -1
onready var point = $Center



func _input(event):
	if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
		var distance = (event.position - self.global_position).length()
		if distance <= radius or event.index == dragging:
			dragging = event.index
			point.set_global_position(event.position)
			
			if distance > radius:
				var dir = point.position.normalized()
				point.position = dir * radius
				
	if event is InputEventScreenTouch and !event.is_pressed():
		if(event.index == dragging):
			dragging = -1
			point.position = Vector2.ZERO

func get_joystick_input():
	return point.position.normalized()
