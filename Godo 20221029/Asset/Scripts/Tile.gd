extends StaticBody2D

export var startTile = false
var hasBuilt: bool = false
var canPlaceBuiding : bool = false

onready var highlight : Sprite = $HightLine
onready var buildingIcon : Sprite = $Icon

func _ready():
	add_to_group("Tiles")
	if startTile:
		place_building(Manager.base_texture)

func toggle_highlight(toggle):
	highlight.visible = toggle
	canPlaceBuiding = toggle

func place_building(var buildingTexture):
	if buildingTexture != null:
		hasBuilt = true
		buildingIcon.texture = buildingTexture


func _on_Tile_input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch or event is InputEventScreenTouch:
		if event.pressed:
			if canPlaceBuiding:
				place_building(Manager.current_Build_texture)
				canPlaceBuiding = false
				hasBuilt = true
				get_tree().call_group("Operation", "hide_all_grids_highlight")
				get_tree().call_group("Operation", "update_builtGrids", [self])
