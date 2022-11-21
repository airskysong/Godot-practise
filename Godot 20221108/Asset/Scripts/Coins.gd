extends Area2D

onready var anim = $AnimationPlayer
onready var audio = $AudioStreamPlayer2D


func picked():
	audio.play()
	anim.play("rotate")
	yield(anim, "animation_finished")
	Globals.update_coins()
	queue_free()


func _on_Coins_body_entered(Player):
	if Player:
		picked()
