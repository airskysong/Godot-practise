extends Control

signal finished

func _ready():
	self.hide()
	var size = get_viewport_rect().size
	rect_size = size

func begin_transition(var time):
	self.show()
	var tween = create_tween()
	tween.tween_property($ColorRect,"color:a", 1.0, time).from(0.0)
	tween.tween_callback(self, "close")

func end_transition(var time):
	self.show()
	var tween = create_tween()
	tween.tween_property($ColorRect,"color:a", 0.0, time).from(1.0)
	tween.tween_callback(self, "close")

func close():
	self.hide()
	emit_signal("finished")
