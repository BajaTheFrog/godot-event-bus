extends Area2D
class_name ClickableArea2D


signal area_clicked()


func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		self.on_click()


func on_click():
	print("clicked")
	emit_signal("area_clicked")
