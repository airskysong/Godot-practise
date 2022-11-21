extends Area2D

onready var sprite = $Sprite as Sprite
var sprite_scale 
var is_click := false

var tile_pos := Vector2()
var has_unit := false as bool
var can_move := false as bool

var unit = null

signal tile_press(tile)

onready var icon = $SelectedIcon
func _ready():
	randomize()
	sprite_scale = sprite.scale
	set_random_texture()

func set_random_texture():
	sprite.frame = rand_range(0, 7)

func set_highlight():
	sprite.modulate = Color.darkgreen
	can_move = true

func hide_highlight():
	sprite.modulate = Color.white
	can_move = false


func _on_Tile_input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch or event is InputEventMouseButton:
		if event.pressed == true:
			emit_signal("tile_press", self)
			GameData.select_tile(self)
			if GameData.last_selected_grid:
				GameData.last_selected_grid.hide_selected_icon()
			GameData.current_selected_grid.show_selected_icon()

		
func _on_Tile_area_entered(area):
	if !has_unit:
		has_unit = true
		unit = area


func _on_Tile_area_exited(area):
	if has_unit and unit == area:
		has_unit = false
		unit = null

func show_selected_icon():
	icon.show()

func hide_selected_icon():
	icon.hide()
