extends Node2D

onready var coin_text := $CanvasLayer/Control/HB/CoinText
onready var pause_btn := $CanvasLayer/Control/HB/PauseBtn
onready var anim := $CanvasLayer/AnimationPlayer

onready var resume_btn := $CanvasLayer/Control/PauseMenu/VBoxContainer/ResumeBtn
onready var titleBtn := $CanvasLayer/Control/PauseMenu/VBoxContainer/TitleBtn

func _ready():
	add_to_group("hub_ui")
	pause_btn.connect("button_down", self, "show_pause_menu")
	resume_btn.connect("button_down", self, "resume")
	titleBtn.connect("button_down", self, "back_title")
	
func show_pause_menu()->void:
	anim.play("show")
	get_tree().paused = true

func show_coins(value:int)->void:
	coin_text.text = ":" + str(value)

func resume()->void:
	pause_btn.pressed = false
	anim.play_backwards("show")
	get_tree().paused = false

func back_title()->void:
	get_tree().paused = false
	var path = load("res://Asset/Objects/UI/StartMenu.tscn")
	ScreenFade.change_and_translate_scene(path)
