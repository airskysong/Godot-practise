extends Node2D


onready var start_btn := $StartLayer/Control/VBoxContainer3/Menu/MainMenu/StartBtn
onready var option_btn := $StartLayer/Control/VBoxContainer3/Menu/MainMenu/OptionBtn
onready var exit_btn := $StartLayer/Control/VBoxContainer3/Menu/MainMenu/ExitBtn

onready var bgm_btn := $StartLayer/Control/VBoxContainer3/Menu/OptionMenu/BgmBtn
onready var sfx_btn := $StartLayer/Control/VBoxContainer3/Menu/OptionMenu/SfxBtn
onready var back_btn := $StartLayer/Control/VBoxContainer3/Menu/OptionMenu/BackBtn

onready var anim := $StartLayer/Control/Transition

func _ready():
	start_btn.connect("button_down", self, "start")
	option_btn.connect("button_down", self, "option")
	exit_btn.connect("button_down", self, "exit")
	
	bgm_btn.connect("button_down", self, "bgm")
	sfx_btn.connect("button_down", self, "sfx")
	back_btn.connect("button_down", self, "back")


func start():
	var path = load("res://Asset/Objects/Level1.tscn")
	ScreenFade.change_and_translate_scene(path)

func option():
	anim.play("show")

func exit():
	get_tree().quit()

func bgm():
	pass

func sfx():
	pass

func back():
	anim.play_backwards("show")


func _on_Transition_animation_finished(anim_name):
	anim.play("tile_rotation")
