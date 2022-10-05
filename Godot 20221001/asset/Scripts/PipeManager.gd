extends Timer
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var pipe_scn = preload("res://asset/Object/Pipe.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("timeout", self, "on_timeout")
	add_to_group("GAME_STATE")

func on_timeout():
	var pipe = pipe_scn.instance()
	add_child(pipe)

func on_game_over():
	paused = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
