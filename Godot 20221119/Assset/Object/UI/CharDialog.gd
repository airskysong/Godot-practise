extends CanvasLayer


var avatars = {"character_001": preload("res://Assset/UI/Avatars/1.png"),
"character_002": preload("res://Assset/UI/Avatars/2.png")}

var content := []
var index := 0
var interval = 0.1

onready var avatar_rect = $Control/charBox/Avatar
onready var dialog_label = $Control/charBox
onready var little_sign = $Control/charBox/Sign
onready var tween = $Control/charBox/Tween

func _ready():
#	hide()
	test()


func test():
	show_dialog([{"character_001":"你好啊，我是测试内容1"},
	{"character_002":"不客气，这是应答内容2"},
	{"character_001":"你好啊，我是测试内容3"},
	{"character_002":"不客气，这是应答内容4"}
	])

func _unhandled_input(event):
	if event is InputEventKey and event.is_action_pressed("ui_end"):
		if tween.is_active():
			tween.stop_all()
			dialog_label.percent_visible = 1
		else:
			index += 1
			if content.size() - 1 > index:
				_show_dialog()
			else:
				hide()
	get_tree().set_input_as_handled()


func show_dialog(var _content):
	show()
	self.content = _content
	_show_dialog()

func _show_dialog():
	var dict = content[index]
	var texture_key = dict.keys()[0]
	avatar_rect.texture = avatars.get(texture_key)
	var dialog_text = dict.get(texture_key)
	dialog_label.text = dialog_text
	var count = dialog_text.length() * interval
	tween.interpolate_property(dialog_label, "percent_visible", 0, 1, count, Tween.TRANS_LINEAR,Tween.EASE_OUT)
	tween.start()
