extends Node

export(PackedScene) var coin

var level = 0
var score = 0
var left_time = 0
var playing = true
var oneturnCoins = 0
var current_pickup_count = 0
var screensize = Vector2.ZERO
var timesize = 5

func updateScoreUI():
	get_tree().call_group("Hub", "on_hub_updateScore", score)
	
func updateTimeUI():
	get_tree().call_group("Hub", "on_hub_updateTime", left_time)

func gameOver():
	for c in $CoinContainer.get_children():
		c.queue_free()
	#通知注册State组的组件
	get_tree().call_group("State", "on_state_gameover")
	$GameTimer.stop()

func _ready():
	randomize()
	screensize = get_viewport().get_visible_rect().size

func spawn_coin():
	oneturnCoins = level + 3
	for _i in range(oneturnCoins):
		var c = coin.instance()
		#缓冲，防止过快生成
		$CoinContainer.call_deferred("add_child", c)
#		$CoinContainer.add_child(c)
		c.position = Vector2(rand_range(0, screensize.x),
		rand_range(0, screensize.y))

func start_game():
	initData()
	$Player.set_data($PlayerPosition.position, screensize)
	$GameTimer.start()
	spawn_coin()
	updateScoreUI()
	updateTimeUI()


func initData():
	level = 0
	score = 0
	left_time = timesize
	playing = true
	current_pickup_count = 0

func clear_stage():
	left_time += 5
	level += 1
	updateScoreUI()
	updateTimeUI()
	$Player.set_data($PlayerPosition.position, screensize)
	spawn_coin()


func _on_Hub_startgame():
	start_game()


func _on_GameTimer_timeout():
	left_time -= 1
	updateTimeUI()
	if left_time <= 0:
		gameOver()


func _on_Player_hurt():
	gameOver()


func _on_Player_pickup():
	score += 1
	oneturnCoins -= 1
	updateScoreUI()
	if oneturnCoins <= 0:
		clear_stage()


