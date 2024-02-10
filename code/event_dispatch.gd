extends Node
# Autoload: EventDispatch
# Holds onto the service that tracks event 
# subscription and broadcasting information


onready var dispatch_service = $Dispatch


func service() -> EventDispatchService:
	return dispatch_service
