extends Resource

export(Texture) var pic
export(String) var enemy_name
export(int) var max_health
export(int) var defence
export(int) var attack

func _init(pic = null, enemy_name = null, max_health=0, defence=0, attack=0):
	self.pic = pic
	self.enemy_name = enemy_name
	self.max_health = max_health
	self.defence = defence
	self.attack = attack
	
