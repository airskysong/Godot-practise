extends Node2D

var res
var num = ["3", "2", "1", "start", ""]
var index = 0
onready var label
func _ready():
	var tween := create_tween()
	label = $CanvasLayer/Control/CenterContainer/Label
	var obj =  load("res://Asset/level.tres")
	res = obj.duplicate()
	res.size = 100
	label.text = num[index]
	label.add_font_override("font", res)
#	var font = label.get("custom_fonts/font")
	tween.tween_callback(label, "show")
	tween.set_parallel(true)
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	for _s in range(0, 4):
		tween.chain().tween_property(res, "size", 10, 1)
		tween.tween_property(label, "modulate", Color(1, 1, 1, 0), 1)
		tween.chain().tween_callback(self, "reset")
	tween.chain().tween_callback(self, "show_content")

func reset():
	res.size = 100
	label.modulate = Color(1, 1, 1, 1)
	index += 1
	label.text = str(num[index])

func show_content():
	var next = load("res://interface.tscn")
	get_tree().change_scene_to(next)
	
