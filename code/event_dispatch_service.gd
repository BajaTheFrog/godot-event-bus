extends Node
class_name EventDispatchService
# The service that is responsible for tracking subscriptions
# to events and broadcasting them out.
# Follows a basic publisher/subscriber pattern. 


# Dictionary of event_id to array of subscriptions
onready var subscription_dictionary = Dictionary()


# subscribe to an event type
# dispatch stores subscriber, event id, and function to call
func subscribe(event_id, subsciber: Object, function_name: String) -> void:
	# TODO: consider accepting a type the subscriber accepts so that 
	# the dispatch can cast _for_ them and the handler can be written for the type in mind
	# so that the subscriber doesn't have to cast the incoming Event
	var subscription = EventSubscription.new(event_id, subsciber, function_name)
	_add_subscription(subscription)
		
		
func _add_subscription(subscription: EventSubscription) -> void:
	var event_id = subscription.event_id
	
	if not event_id in subscription_dictionary:
		subscription_dictionary[event_id] = [subscription]
	else:
		var existing_subs = subscription_dictionary[event_id]
		for existing_sub in existing_subs:
			var subscriber_subscribed = subscription.subscriber == existing_sub.subscriber
			var function_subscribed = subscription.function_name == existing_sub.function_name
			if subscriber_subscribed and function_subscribed:
				# this subscription already exists, exit function
				return
		
		# if it doesn't already exist, add it!
		existing_subs.append(subscription)
		subscription_dictionary[event_id] = existing_subs


# broadcast an event 
# events are objects with a particular id
# up to subscribers to cast and parse
func broadcast(event: Event) -> void:
	var event_id = event.event_id
	if event_id in subscription_dictionary:
		var existing_subs = subscription_dictionary[event_id]
		for existing_sub in existing_subs:
			var subscriber = existing_sub.subscriber
			if not is_instance_valid(subscriber):
				_remove_invalid_subscription(event_id, existing_subs, existing_sub)
				continue
			
			var function = existing_sub.function_name
			if not subscriber.has_method(function):
				continue
				
			# Call the function and pass in the event
			subscriber.call(function, event)
		
			
# remove a subscription from an invalid subscriber
# i.e. one that has been freed
func _remove_invalid_subscription(event_id, subscription_array: Array, subscription_to_remove: EventSubscription):
	var index_to_remove = subscription_array.find(subscription_to_remove)
	if index_to_remove >= 0:
		subscription_array.remove(index_to_remove)
	
	subscription_dictionary[event_id] = subscription_array
