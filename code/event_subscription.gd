extends Reference
class_name EventSubscription


var event_id
var subscriber: Object
var function_name: String


func _init(id, sub: Object, func_name: String):
	self.event_id = id
	self.subscriber = sub
	self.function_name = func_name
