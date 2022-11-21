extends Area2D


signal hit

func _on_HitBox_area_entered(HurtBox):
	emit_signal("hit")
	HurtBox.hurt()
