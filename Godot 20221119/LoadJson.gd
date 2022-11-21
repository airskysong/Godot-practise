extends Node2D
class_name LoadJson


export(String, FILE, "*.json") var file_path : String

func _ready():
	pass
	
func loadFile():
	var file := File.new()
	
	file.open(file_path, File.READ)
	var re = parse_json(file.get_as_text())
	return re
