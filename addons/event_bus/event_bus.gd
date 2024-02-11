extends Node
# Autoload: EventBus
# Holds onto the service that tracks event 
# subscription and broadcasting information


onready var bus_service = $BusService


func service() -> EventBusService:
	return bus_service
