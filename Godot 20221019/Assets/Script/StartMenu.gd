extends Control

onready var next = preload("res://Assets/Object/level1.tscn")

func _ready():
	$AnimationPlayer.play("idle")

func _input(event):
	if event is InputEventScreenTouch and event.is_pressed():
		get_tree().change_scene_to(next)
