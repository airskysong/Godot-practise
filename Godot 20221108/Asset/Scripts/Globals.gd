extends Node2D

var total_coins = 0
var current_coins = 0


func update_coins()->void:
	current_coins += 1
	for c in get_tree().get_nodes_in_group("hub_ui"):
		if c:
			c.show_coins(current_coins)
