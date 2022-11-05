extends Control

onready var retryBtn = $GameOverPanel/RetryBtn
onready var backBtn = $GameOverPanel/BackBtn
onready var missText  = $GameOverPanel/MissLabel
onready var timeText = $GameOverPanel/TimeLabel

func _ready():
	hide()
	init()

func init():
	retryBtn.connect("button_down", self, "retry")
	backBtn.connect("button_down", self, "back_to_title")

func update_miss_ui(var num):
	missText.text = "失误：" + str(num)

func update_time_ui(var num):
	timeText.text = "耗时：" + str(num)

func retry():
	var retry_scene = load("res://Asset/Object/Level.tscn")
	get_tree().change_scene_to(retry_scene)
	pass

func back_to_title():
	var main_scene = load("res://Main.tscn")
	get_tree().change_scene_to(main_scene)
	pass

func show_game_over_ui():
	show()
	var tween :=create_tween()
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO)
	var end = get_viewport_rect().size.y / 2 - $GameOverPanel.get_rect().size.y / 2
	var x = $GameOverPanel.get_global_rect().position.x
	var y = $GameOverPanel.get_global_rect().position.y
	tween.tween_method($GameOverPanel, "set_global_position", 
	Vector2(x, y), Vector2(x, end), 0.8)
	tween.parallel().tween_property(self, "modulate", 
	Color(1, 1, 1, 1), 0.8).from(Color(1,1,1,0))
	

