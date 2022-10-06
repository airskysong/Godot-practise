extends Timer
var pipe_scn = preload("res://asset/Object/Pipe.tscn")

func _ready():
	connect("timeout", self, "on_timeout")
	add_to_group("GAME_STATE")

func on_timeout():
	var pipe = pipe_scn.instance()
	add_child(pipe)

func on_game_over():
	paused = true
