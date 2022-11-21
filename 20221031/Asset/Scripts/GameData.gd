extends Node

var selected_unit = null

var current_selected_grid = null
var last_selected_grid = null

func select_tile(var tile):
	last_selected_grid = current_selected_grid
	current_selected_grid = tile
