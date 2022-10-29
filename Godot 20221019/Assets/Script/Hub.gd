extends Control

func _ready():
	var tween := create_tween()
	tween.tween_callback($ColorRect, "show")
	tween.tween_property($ColorRect, "color:a", 1.0, 0.3)
	tween.tween_property($ColorRect, "color:a", 0.0, 0.3)
	tween.tween_callback($ColorRect, "hide")
	
