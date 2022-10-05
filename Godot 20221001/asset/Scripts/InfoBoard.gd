extends TextureRect


func _ready():
	add_to_group("GAME_STATE")
	set_process(false)
	
func on_game_over():
	#现在分数
	$currentScore.text = "完成:" + str(GameData.score)
	#最大分数
	$maxScore.text = "最大记录:" + str(GameData.load_record())
	#显示计分板
	$AnimationPlayer.play("show")

func _process(delta):
	if(Input.is_mouse_button_pressed(1)):
		get_tree().call_group("GAME_STATE","on_game_start")

func on_board_shown():
	set_process(true)
