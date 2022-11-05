extends Node2D

export(PackedScene) var tile_model
export(Vector2) var map_size


var rect := Vector2.ONE
var start_pos = Vector2.ZERO
var tile_size = 64

var max_tiles_x = 0
var max_tiles_y = 0

var all_grids = {}

func _ready():
	randomize()
	rect = get_viewport_rect().size
	
	max_tiles_x = rect.x / tile_size as int
	max_tiles_y = rect.y / tile_size as int

	create_map(map_size.x, map_size.y)
	
	$Player1/RedWarrior.position = get_grid_position(0, 0)
	$Player1/RedWarrior2.position = get_grid_position(0, 1)
	
	

func create_map(var v, var h):
	v = max_tiles_x if v > max_tiles_x else v
	h = max_tiles_y if h > max_tiles_y else h
	
	start_pos.x = (rect.x - v * tile_size) / 2 + tile_size / 2
	start_pos.y = (rect.y - h * tile_size) / 2 + tile_size / 2
	for  x in range(0,  v):
		for y in range(0, h):
			var tile = tile_model.instance()
			tile.position.x = start_pos.x + tile_size * x
			tile.position.y = start_pos.y + tile_size * y
			tile.tile_pos = Vector2(x, y)
			tile.connect("tile_press", self, "unit_action")
			
			all_grids[Vector2(x, y)] = tile
			self.add_child(tile)

func show_move_highlight(var start, var distance):
#	var start = parameters[0] as Vector2
#	var distance = parameters[1] as int
	hide_all_highlight()
	if invalid_grid(start.x, start.y):
		for offset_x in range(-distance, distance+1):
			for offset_y in range(-distance, distance+1):
				if offset_x == 0 && offset_y == 0:
					continue
				var current = Vector2(start.x + offset_x, start.y + offset_y)
				if invalid_grid(current.x, current.y)==true:
					if abs(offset_x) + abs(offset_y) > distance:
						continue
					var current_grid = all_grids[current]
					current_grid.set_highlight()


func hide_all_highlight():
	for g in all_grids.values():
		g.hide_highlight()

func invalid_grid(var x, var y):
	if  x >= 0 and x < map_size.x:
		if y >= 0 and y < map_size.y:
			return true
	return false

func get_grid_position(var x, var y):
	if invalid_grid(x, y):
		return all_grids[Vector2(x, y)].position
	return Vector2.ZERO

func unit_action(var tile):
	
	var has_unit = tile.has_unit
	var can_move = tile.can_move
	var unit = tile.unit
	var selected_unit = GameData.selected_unit

	#在已经选择单位的情况下点击范围内的各自时，移动
	if selected_unit and not has_unit and can_move:
		selected_unit.start_move(tile.position)
		tile.has_unit = true
		tile.unit =selected_unit
		GameData.selected_unit = null
		hide_all_highlight()

	#在已经选择单位的情况下点击一个单位,①选择该单位②重复选择的单位会取消选择
	elif selected_unit and has_unit:
		if selected_unit != unit:
			GameData.selected_unit = unit
			show_move_highlight(tile.tile_pos, unit.move_range)
		else:
			GameData.selected_unit = null
			hide_all_highlight()
	#在没有选定单位的情况下点击一个单位会选择它，并显示移动范围
	elif not selected_unit and has_unit:

		if unit.moving:
			return 
		GameData.selected_unit = unit		
		show_move_highlight(tile.tile_pos, unit.move_range)
	#在没有选定单位和没有单位的情况下，啥也不做
	elif not selected_unit and not has_unit:
		pass
		


