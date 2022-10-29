extends Control

var miss
var time = 0
var remain

var answer=[]
var index = 0

onready var tips = load("res://Tips.tscn")

func _ready():
	$Transition.end_transition(0.3)
	$Timer.connect("timeout", self, "show_time")
	$Timer.start()

	randomize()
	var re = create_random_list()
	remain = answer.size()
	miss = 0
	update_miss_ui()
	update_remain_ui()
	for c in $GridContainer.get_children():
		var btn = c as Button
		if btn!=null:
			btn.connect("clicked", self, "on_btn_clicked")
			c.text = str(re.pop_front())
	
func create_random_list():
	var list1 = []
	var sum = 0
	for _c in range(0, 16):
		sum += rand_range(1,5) as int
		list1.append(sum)
	answer = list1.duplicate()
	var list2 = []
	for _c in range(0, 16):
		var r = list1.pop_at(rand_range(0, list1.size() as int))
		list2.append(r)
	return list2
	
func show_time():
	time += 1
	$TimeLabel.text = str(time)
	
func on_btn_clicked(var msg):
	var obj = msg[0] as Grid_Btn
	var num = msg[1] as int
	if check_answer(num):
		obj.disabled = true
		remain -= 1
		play_effect(obj.get_global_rect().position + obj.get_minimum_size()/2)
		update_remain_ui()
		
	else:
		miss += 1
		update_miss_ui() 


func play_effect(var pos):
	$Effect/Particles2D.position = pos
	$Effect/Particles2D.restart()
	var tip = tips.instance()
	$Position2D.add_child(tip)
	var player = tip.get_node_or_null("Label/AnimationPlayer") as AnimationPlayer
	player.play("plus")
	yield(player,"animation_finished")
	tip.queue_free()


func update_miss_ui():
	$MarginContainer/MissLabel.text  = "miss:" + str(miss)

func update_remain_ui():
	$MarginContainer/RemainLabel.text = "remain:" + str(remain)
	
func check_answer(var num):
	if index < answer.size() && num == answer[index]:
		index += 1
		return true
