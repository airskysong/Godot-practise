extends Node2D

var allGrids = []
var builtGrids = []
var gridSize = 64

var dirs = [Vector2.UP,
Vector2.DOWN,
Vector2.LEFT,
Vector2.RIGHT
]

func _ready():
	add_to_group("Operation")
	allGrids = $Tiles.get_children()
	for g in allGrids:
		if g.hasBuilt:
			builtGrids.append(g)
			
func get_grid(var pos):
	for g in allGrids:
		if g.position == pos && !g.hasBuilt:
			return g
	return null

func hide_all_grids_highlight():
	for grid in allGrids:
		grid.toggle_highlight(false)

func show_all_grids_highlight():
	for g in builtGrids:
		for dir in dirs:
			var pos = g.position + gridSize * dir
			var neigbour_gird = get_grid(pos)
			if neigbour_gird != null:
				neigbour_gird.toggle_highlight(true)

func update_builtGrids(var grid):
	builtGrids.append(grid[0])
