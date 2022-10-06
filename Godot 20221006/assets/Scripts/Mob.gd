#设置敌人动画播放的脚本
extends RigidBody2D

#一开始随机播放动画
func _ready():
	$AnimatedSprite.playing = true;
	var animators = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation =  animators[randi()%animators.size()]
	
#离开屏幕后自动销毁
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
