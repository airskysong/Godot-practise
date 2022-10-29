extends Button
class_name Grid_Btn

signal clicked(msg)

func _ready():
	self.connect("button_down", self, "send_msg")
	
func send_msg():
	var text = self.text
	emit_signal("clicked", [self, text])
