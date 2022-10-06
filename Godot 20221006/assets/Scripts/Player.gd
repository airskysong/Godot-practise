#本脚本通过改变Area2D里的属性position来让控制的物体移动
extends Area2D

#定义面板的速度变量 关键字export
export var speed = 400 
#记录窗口大小
var screen_size 
#使用自定义信号，反馈玩家碰撞的信息到对它感兴趣的对象
signal hit

func _ready():
#取得当前视口的大小
	screen_size = get_viewport_rect().size 
	hide()

# move_up, move_**均为在项目设置->input里自定义的按键变量,可以由is_action_pressed捕获
func _process(delta):
 #当前玩家的矢量
	var velocity = Vector2.ZERO
	if(Input.is_action_pressed("move_up")):
		velocity.y -= 1
	if(Input.is_action_pressed("move_down")):
		velocity.y += 1
	if(Input.is_action_pressed("move_left")):
		velocity.x -= 1
	if(Input.is_action_pressed("move_right")):
		velocity.x += 1
	if(velocity.length()>0):
		velocity = velocity.normalized()*speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
# 根据玩家输入的矢量来决定sprite是否翻转，注意Gt的坐标系是从右上角开始的
	if(velocity.x !=0 ):
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif (velocity.y !=0 ):
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0
		

#当玩家碰撞到其他的碰撞体时会回调这个函数
func _on_Player_body_entered(_body):
	#延迟关闭碰撞体
	$CollisionShape2D.call_deferred("set", "disabled", true)
	hide()
	emit_signal("hit")


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
