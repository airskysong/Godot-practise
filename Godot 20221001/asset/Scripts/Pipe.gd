extends Node2D

func _ready():
	add_to_group("GAME_STATE")
	set_process(true)
	position.y += randf() * 200 - 100

func _process(delta):
	position += Vector2.LEFT*200.0*delta
	if(position.x < 0):
		queue_free()

func on_game_over():
	set_process(false)
