extends Camera2D

var can_shake
var shake_strength = 10
var shake_duration = 0.3

func _ready():
	randomize()
	self.position = get_viewport_rect().size / 2


func begin_shake():
	var tween := create_tween()
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_method(self, "shake", shake_strength, 0, shake_duration)
	pass

func shake(var strength):
	offset.x = rand_range(0, strength)
	offset.y = rand_range(0, strength)
