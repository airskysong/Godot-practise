extends Area2D

export(int) var player_speed = 200
var screen_size = Vector2.ZERO
var velocity

signal pickup
signal hurt

func _ready():
	self.hide()

# 人物控制器处理输入和动画
func _physics_process(delta):
	handle_input()
	position += velocity * delta
	limit_player_move()
	handle_animation()

func set_data(var pos:Vector2, var size:Vector2):
	set_physics_process(true)
	self.screen_size = size
	self.position = pos
	self.show()

# 处理动画
func handle_animation():
	if velocity.length() > 0:
		$AnimatedSprite.animation = "run"
		$AnimatedSprite.flip_h = velocity.x < 0
	else:
		$AnimatedSprite.animation = "idle"

# 处理输入
func handle_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed("input_left"):
		velocity.x -= 1
	if Input.is_action_pressed("input_right"):
		velocity.x += 1
	if Input.is_action_pressed("input_up"):
		velocity.y -= 1
	if Input.is_action_pressed("input_down"):
		velocity.y += 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * player_speed

# 限制玩家在视口范围内
func limit_player_move():
	 position.x = clamp(position.x, 0, screen_size.x)
	 position.y = clamp(position.y, 0, screen_size.y)

# 玩家死亡时
func die():
	set_physics_process(false)
	$AnimatedSprite.animation = "hurt"
	yield($AnimatedSprite,"animation_finished")
	self.hide()
	
# 碰撞事件
func _on_Player_area_entered(area):
	if area.is_in_group("coin"):
		var c = area as Coin 
		c.on_pick_up()
		emit_signal("pickup")
	elif area.is_in_group("obstancle"):
		die()
		emit_signal("hurt")

func on_state_gameover():
	die()
