extends ColorRect
class_name ColorBar


func _ready():
	self.modulate = Color(0, 0, 0, 1)
	EventBus.service().subscribe(RedSprite.ClickedRedEvent.ID, self, "_on_red_clicked")
	EventBus.service().subscribe(GreenSprite.ClickedGreenEvent.ID, self, "_on_green_clicked")
	EventBus.service().subscribe(BlueSprite.ClickedBlueEvent.ID, self, "_on_blue_clicked")


func _on_red_clicked(_event: Event):
	self.modulate.r += 0.05
	
	
func _on_green_clicked(_event: Event):
	self.modulate.g += 0.05
	
	
func _on_blue_clicked(_event: Event):
	self.modulate.b += 0.05


func _on_reset_button_pressed():
	self.modulate = Color(0, 0, 0, 1)
