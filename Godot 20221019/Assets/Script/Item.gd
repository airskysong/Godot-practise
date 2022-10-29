extends Area2D

export(Texture) var red_key
export(Texture) var green_key

enum item_type{
	RED_KEY, GREEN_KEY
}

var current_type

func _ready():
	set_type(1)

func set_type(var type:int):
	var sprite = $Sprite
	match type:
		item_type.RED_KEY:
			sprite.texture = red_key
		item_type.GREEN_KEY:
			sprite.texture = green_key
	current_type = type

func picked_up():
	$CollisionShape2D.set_deferred("disable", true)
	do_tween()


func do_tween():
	$Tween.interpolate_property(self, "scale", scale, scale * 1.5, 0.3,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	$Tween.interpolate_property(self, "modulate",  Color(1, 1, 1, 1), Color(1, 1, 1, .25), 0.3,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	$Tween.start()


func _on_Tween_tween_all_completed():
	queue_free()
	get_tree().call_group("key_door", "open_door", current_type)
