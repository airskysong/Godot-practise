extends Area2D

func _ready():
	add_to_group("GAME_STATE")
	connect("body_exited", self, "_on_body_exited")

func _on_body_exited(_body):
	if(_body.name == "Player"):
		GameData.score += 1
		AudioManager.play("sfx_point")
		#加分以后通过SceenTree把新的分数更新给所有想接受这个消息的节点
		get_tree().call_group("SCORE", "on_score_updated", GameData.score)

func on_game_over():
	call_deferred("set_monitoring", false)
	disconnect("body_exited", self, "_on_body_exited")
