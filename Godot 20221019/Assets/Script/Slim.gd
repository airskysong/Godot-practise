extends "res://Assets/Script/Character.gd"

var dirs = moves.keys()

func _ready():
	randomize()
	can_move = false
	yield(get_tree().create_timer(2), "timeout")
	can_move = true
	facing = dirs[randi()%4]

func _physics_process(_delta):
	if can_move:
		if not move(facing):
			facing = dirs[randi()%4]
