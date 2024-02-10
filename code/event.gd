extends Reference
class_name Event
# An object representing information about an event
# By extending Reference we can make sure it is automatically
# cleaned up when nothing else has a reference to it

# This is intentionally untyped
# as you may want to use a string or int or something else
var event_id

func _init(id).():
	self.event_id = id

