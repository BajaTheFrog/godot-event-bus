extends ClickableSprite
class_name RedSprite


var times_clicked = 0
var original_position = Vector2.ZERO


func _ready():
	original_position = self.position


func _on_click():
	times_clicked += 1
	var event = ClickedRedEvent.new(times_clicked)
	EventBus.service().broadcast(event)
	

###### Event Definition ###### 


class ClickedRedEvent extends Event:
	const ID = "CLICKED_RED_EVENT"
	var times_clicked
	
	func _init(clicks).(ID):
		self.times_clicked = clicks
