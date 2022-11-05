extends Node2D

onready var anim := $"AnimationPlayer" as AnimationPlayer

func _ready():
	if anim != null:
		anim.play("idle")
	pass
