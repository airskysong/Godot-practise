extends Node2D

export(PackedScene) var item

var has_open_red = false
var has_open_green = false


func _ready():
	self.add_to_group("key_door")
	self.add_to_group("game_state")
	limit_player_camera()
	set_spawn_point()
	
#
func limit_player_camera():
	var cam = $Player/Camera2D
	var fl = $Floor
	if cam != null and fl != null:
		var cellsize = fl.cell_size
		var rect = fl.get_used_rect()
		cam.limit_left = cellsize.x * rect.position.x
		cam.limit_top = cellsize.y * rect.position.y
		cam.limit_right = cellsize.x * rect.end.x
		cam.limit_bottom = cellsize.y * rect.end.y

#	
func set_spawn_point():
	var spawn = $Spawn
	if spawn != null:
		$Spawn.hide()
		var player_point = spawn.get_used_cells_by_id(0)	
		var enemy_point = spawn.get_used_cells_by_id(1)	
		var red_key_point = spawn.get_used_cells_by_id(2)	
		var green_key_point =spawn.get_used_cells_by_id(3)

		$Player.position = get_cells_position(player_point[0], spawn)
		$Slim.position = get_cells_position(enemy_point[0], spawn)
		
		var green_key = item.instance()
		green_key.position = get_cells_position(green_key_point[0], spawn)
		self.add_child(green_key)
		green_key.set_type(1)
		
		var red_key = item.instance()
		red_key.position = get_cells_position(red_key_point[0], spawn)
		self.add_child(red_key)
		red_key.set_type(0)


func open_door(var type):
	match type:
		0:
			if not has_open_red:
				has_open_red = true
				var red_doors = $Door.get_used_cells_by_id(0)
				for r in red_doors:
					$Door.set_cellv(r, -1)
		1:
			if not has_open_green:
				has_open_green = true
				var green_doors = $Door.get_used_cells_by_id(1)
				for g in green_doors:
					$Door.set_cellv(g, -1)

func game_over():
	var next = preload("res://Assets/Object/Game Over.tscn")
	get_tree().change_scene_to(next)

func get_cells_position(var pos, var object):
	return object.map_to_world(pos) + $Floor.cell_size/2
		

