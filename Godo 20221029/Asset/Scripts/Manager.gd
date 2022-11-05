extends Node

var current_food = 0
var current_metal = 0
var current_oxygen = 0
var current_energy = 0
var current_turn = 0

var mine_texture  = load("res://Asset/Sprites/Mine.png")
var solar_texture  = load("res://Asset/Sprites/SolarPanel.png")
var green_house_texture = load("res://Asset/Sprites/Greenhouse.png")
var base_texture = preload("res://Asset/Sprites/Base.png")

var increase_food = 0
var increase_metal = 0
var increase_oxygen = 0
var increase_energy = 0


var hasBuild = false

var current_Build_texture = null

enum build_type {
	MINE,
	SOLAR,
	GREEN_HOUSE,
}

func update_data_one_turn():
	current_food += increase_food
	current_metal += increase_metal
	current_oxygen += increase_oxygen
	current_energy += increase_energy
	
func update_current_Build_type(var type):
	match type:
		build_type.MINE:
			current_Build_texture = mine_texture
			increase_metal += 10
			increase_oxygen += 10
		build_type.SOLAR:
			current_Build_texture = solar_texture
			increase_food += 10
			increase_metal -= 5
			increase_oxygen -= 5
			increase_energy += 10
		build_type.GREEN_HOUSE:
			current_Build_texture = green_house_texture
			increase_food += 15
			increase_metal -= 5
			increase_oxygen -= 5
			increase_energy += 15

	
