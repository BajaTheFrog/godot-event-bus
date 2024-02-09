extends ClickableSprite
class_name GreenSprite


func _ready():
	EventDispatch.service().subscribe(RedSprite.ClickedRedEvent.ID, self, "_on_red_click")


func _on_click():
	var green_event = ClickedGreenEvent.new(self.rotation_degrees)
	EventDispatch.service().broadcast(green_event)


func _on_red_click(event: Event):
	var red_event = event as RedSprite.ClickedRedEvent
	if red_event:
		var tween = create_tween()
		tween.tween_property(self, "rotation_degrees", 7 * red_event.times_clicked, 0.1)


###### Event Definition ###### 


class ClickedGreenEvent extends Event:
	const ID = "CLICKED_GREEN_EVENT"
	var rot_degrees
	
	func _init(degrees).(ID):
		self.rot_degrees = degrees
