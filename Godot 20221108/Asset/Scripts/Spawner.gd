extends Position2D

export(PackedScene)var monster
export var interval := 3

onready var timer = $Timer

func _on_VisibilityNotifier2D_screen_entered():
	timer.start(interval)


func _on_VisibilityNotifier2D_screen_exited():
	timer.stop()


func _on_Timer_timeout():
	var m = monster.instance()
	self.add_child(m)
