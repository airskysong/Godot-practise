extends Area2D
class_name Coin

# 被时取时销毁
func on_pick_up():
	$CollisionShape2D.set_deferred("disabled", true)
	dotween()

func dotween():
	var tween = $Tween
	tween.interpolate_property($AnimatedSprite,"scale", 
	$AnimatedSprite.scale,
	$AnimatedSprite.scale * 0.5, 
	0.2, 
	Tween.TRANS_BOUNCE, 
	Tween.EASE_IN_OUT)
	tween.start()



func _on_Tween_tween_all_completed():
	queue_free()
