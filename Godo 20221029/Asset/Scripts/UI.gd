extends Control

onready var foodMetalText = $BG/HeaderFoodMetal/FoodMetalText
onready var oxygenEnergyText = $BG/HeaderOxygenEnergy/OxygenEnergyText
onready var turn_text = $BG/TurnText

onready var GreenHouse_btn = $BG/BuidingButtons/GreenHouse
onready var Mine_btn = $BG/BuidingButtons/Mine
onready var solar_btn = $BG/BuidingButtons/Solar
onready var end_turn_btn = $BG/EndTurnButton


func _ready():
	GreenHouse_btn.connect("button_down", self, "build", ["GreenHouse"])
	Mine_btn.connect("button_down", self, "build", ["Mine"])
	solar_btn.connect("button_down", self, "build",  ["solar"])
	end_turn_btn.connect("button_down", self, "end_turn")
	
	update_all_ui()
	

func update_foodMetal_ui(var food, var metal, var increase_food, var increase_metal):
	foodMetalText.text =  str(food) + '('+ str(increase_food)+')' + '\n' +  str(metal) + '('+str(increase_metal)+')'

func update_oxygenEnergy_ui(var oxygen, var energy, var increase_oxygen, var increase_energy):
	oxygenEnergyText.text = str(oxygen) + '('+str(increase_oxygen) +')' + '\n' + str(energy)+ '('+str(increase_energy)+')' 

func update_turns_ui(var turn):
		turn_text.text = "Turn: "+str(turn)
		
func update_all_ui():
	update_foodMetal_ui(Manager.current_food, Manager.current_metal, Manager.increase_food, Manager.increase_metal)
	update_oxygenEnergy_ui(Manager.current_oxygen, Manager.current_energy, Manager.increase_oxygen, Manager.increase_energy)
	update_turns_ui(Manager.current_turn)
	
func build(var name):
	get_tree().call_group("Operation", "show_all_grids_highlight")
	match name:
		"GreenHouse":
			Manager.update_current_Build_type(Manager.build_type.GREEN_HOUSE)
		"Mine":
			Manager.update_current_Build_type(Manager.build_type.MINE)
		"solar":
			Manager.update_current_Build_type(Manager.build_type.SOLAR)
	hide_all_building_btn()
			
func hide_all_building_btn():
	for btn in $BG/BuidingButtons.get_children():
		btn.hide()

func show_all_building_btn():
	for btn in $BG/BuidingButtons.get_children():
		btn.show()

func end_turn():
	Manager.current_Build_texture = null
	Manager.current_turn += 1
	show_all_building_btn()
	Manager.update_data_one_turn()
	update_all_ui()
	pass
