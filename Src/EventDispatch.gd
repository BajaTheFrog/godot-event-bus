extends Node
# class_name Events
# Holds onto services relevant to global 
# (and potentially local) dispatch and communication

onready var dispatch_service = $Dispatch

func service() -> EventDispatchService:
	return dispatch_service
