extends CanvasLayer

onready var attack_btn := $Control/ActionPanel/ActionBox/AttackBtn
onready var defence_btn := $Control/ActionPanel/ActionBox/DefenceBtn
onready var run_btn := $Control/ActionPanel/ActionBox/RunBtn

onready var msg := $Control/MessageBox
onready var msg_text := $Control/MessageBox/MsgText

onready var player_healthbar = $Control/PlayerPanel/PlayerBox/Healthbar
onready var player_health = $Control/PlayerPanel/PlayerBox/Healthbar/HealthValue

func _ready():
	pass
