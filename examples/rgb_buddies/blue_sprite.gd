extends ClickableSprite
class_name BlueSprite


func _ready():
	EventDispatch.service().subscribe(GreenSprite.ClickedGreenEvent.ID, self, "_on_green_click")


func _on_click():
	EventDispatch.service().broadcast(ClickedBlueEvent.new())


func _on_green_click(event: Event):
	var green_event = event as GreenSprite.ClickedGreenEvent
	if green_event:
		var tween_scale = Vector2(1,1)
		if fmod(green_event.rot_degrees, 3.0) == 0:
			tween_scale *= 3
		elif fmod(green_event.rot_degrees, 2.0) == 0:
			tween_scale *= 2
		
		var tween = create_tween()
		tween.tween_property(self, "scale", tween_scale, 0.3)


###### Event Definition ###### 


class ClickedBlueEvent extends Event:
	const ID = "CLICKED_BLUE_EVENT"
	
	func _init().(ID):
		pass
