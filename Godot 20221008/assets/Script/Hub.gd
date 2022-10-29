extends Control

signal startgame

#func _ready():
#	self.add_to_group("Hub")

func hideUI():
	$Message.hide()
	$Startbtn.hide()

func game_over_ui():
	$Message.show()
	updateMessage("Game Over")
	$MessageCountdown.start()
	yield($MessageCountdown, "timeout")
	game_start_ui()
	$MessageCountdown.stop()

func game_start_ui():
	updateMessage("Coin Dash")
	$Startbtn.show()

func updateMessage(var msg:String):
	$Message.text = msg

func on_hub_updateScore(var score:int):
	$MarginContainer/Score.text = "SCORE " + str(score)

func on_hub_updateTime(var time:int):
	$MarginContainer/Time.text = "TIME " + str(time)
	

func _on_Startbtn_button_down():
	hideUI()
	emit_signal("startgame")


func on_state_gameover():
	game_over_ui()
