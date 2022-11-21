extends KinematicBody2D

onready var anim := $AnimationPlayer
onready var sp := $Sprite
onready var timer := $Timer
onready var audio := $AudioStreamPlayer

export var max_speed = 300
export var acceleration_time = 0.2
export var air_accel_rate = 2
export var jump_force = 900
export var gravity = 2000
export var voyote_time = 0.2
export var isinVinsible = false

var acceleration = max_speed / acceleration_time
var air_acceleration = acceleration * air_accel_rate

var velocity = Vector2.ZERO
var is_jumping = false



func _ready():
	limit_camrea()

func input(var delta):
	var direction = Input.get_action_strength("right") - Input.get_action_strength("left")
	var current_accel = acceleration if not is_jumping else air_acceleration
	velocity.x = move_toward(velocity.x, direction * max_speed, delta * current_accel)
	if direction != 0:
		sp.flip_h = direction < 0


func _unhandled_input(event):
	if not event is InputEventKey :
		return
		
	if event.is_action_pressed("jump"):
		if is_on_floor() or timer.time_left > 0:
			is_jumping = true
			velocity.y = -jump_force
			audio.play()

	if event.is_action_released("jump") and velocity.y < -jump_force / 2 :
		velocity.y = -jump_force / 2


func limit_camrea():
	var tilemap = get_parent().get_node_or_null("TileMap")
	if tilemap:
		var t = tilemap as TileMap
		var rect = t.get_used_rect()
		var size = t.cell_size
		var left = rect.position.x * size.x
		var right = rect.end.x * size.x
		var bottom = rect.end.y * size.y
		var camera := get_node_or_null("Camera2D")
		if camera:
			var cam = camera as Camera2D
			cam.limit_left = left
			cam.limit_bottom = bottom
			cam.limit_right = right
			

func play_anim():
	if is_jumping:
		anim.play("jump")
	elif velocity.x != 0:
		anim.play("walk")
	elif velocity.x == 0:
		anim.play("idle")

func _process(delta):
	input(delta)


func _physics_process(delta):
	velocity.y += gravity * delta
	var was_on_floor = is_on_floor()
	velocity = move_and_slide(velocity, Vector2.UP)
	var now_on_floor = is_on_floor()
	if was_on_floor and not now_on_floor and not is_jumping:
		timer.start(voyote_time)
	elif now_on_floor:
		is_jumping = false
	play_anim()


func _on_HurtBox_hurt():
	player_die()

func player_die():
	if isinVinsible:
		return
	ScreenFade.state = ScreenFade.OUT
	yield(ScreenFade, "fade_completed")
	ScreenFade.state = ScreenFade.IN
	Globals.current_coins = 0
	get_tree().change_scene("res://Asset/Objects/Level1.tscn")


func _on_HitBox_hit():
	hit_enemy() 

func hit_enemy():
	velocity.y = - jump_force / 2
	
