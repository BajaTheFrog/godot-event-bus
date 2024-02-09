extends Reference
class_name EventSubscription

var event_id
var subscriber
var function_name

func _init(id, sub, func_name):
	._init()
	self.event_id = id
	self.subscriber = sub
	self.function_name = func_name
