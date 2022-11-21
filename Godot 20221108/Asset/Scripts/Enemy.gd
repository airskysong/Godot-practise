extends KinematicBody2D

onready var anim := $AnimationPlayer
onready var sprite := $Sprite
onready var col := $CollisionShape2D

export var gravity = 2000

var current_dir = face_to.FACE_LEFT

enum face_to{
	FACE_LEFT = -1,
	FACE_RIGHT = 1
}

func _on_HitBox_hit():
	pass 


func _on_HurtBox_hurt():
	dead()

func stop_check():
	call_deferred("set_process", false)
	call_deferred("set_physics_process", false)
	col.set_deferred("disable", true)
	$HurtBox.set_deferred("monitorable", false)
	$HurtBox.set_deferred("monitoring", false)
	$HitBox.set_deferred("monitorable", false)
	$HitBox.set_deferred("monitoring", false)
	
func hurt():
	anim.play("dead")
	yield(anim, "animation_finished")
	queue_free()


func dead():
	pass



