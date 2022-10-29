extends Control


func _ready():
	var tween := create_tween()
	tween.tween_property($ColorRect, "color:a", 0.0, 0.3)
	tween.tween_property($ColorRect, "color:a", 1.0, 0.3)
	$HBoxContainer/RetryBtn.connect("button_down",self, "retry_game")
	$HBoxContainer/BackBtn.connect("button_down",self, "back_title")
	
func retry_game():
	var level = load("res://Assets/Object/level1.tscn")
	go_next_scene(level)

func back_title():
	var title = load("res://Assets/Object/StartMenu.tscn")
	go_next_scene(title)

func go_next_scene(var scene):
	var tween := create_tween()
	tween.tween_property($ColorRect, "color:a", 1.0, 0.3)
	tween.tween_property($ColorRect, "color:a", 0.0, 0.3)
	tween.tween_callback(get_tree(), "change_scene_to", [scene])
