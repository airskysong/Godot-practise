extends Node2D

func _ready():
	$CanvasLayer/interface/Button.connect("button_down",self,"start_game")
	$CanvasLayer/Transition.connect("finished", self, "next")

func start_game():
	$CanvasLayer/Transition.begin_transition(0.3)

func next():
	var next = load("res://Asset/Object/Level.tscn")
	get_tree().change_scene_to(next)
	pass
