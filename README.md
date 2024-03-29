![](docs/bus_banner.png)

# Godot Event Bus
A simple event bus / pubsub implementation with sample(s).

Check out [my blogpost here](https://dev.to/bajathefrog/riding-the-event-bus-in-godot-ped) if you wanna learn more about what an `Event Bus` is or why you would use one in your Godot project!.

## Setup + Installation
This project currently uses the Godot LTS version -> `3.5.3`.
<br><br>

#### Grab the code
Download a zip of the code (or fork/clone the repo if you'd like).
<br><br>

#### Check out the project
Explore the code and examples in the project! 
You can run the example scene and interact with it to see `Events` in action.
<br><br>

#### Add the code to your own project
If/when you want to add the `EventBus` to your own project, copy the folder `res://addons/event_bus` and add it under `res://addons/` in your own project. 
<br><br>

#### Set up the `EventBus` autoload
Add the `EventBus` autoload to your own project by going to `Project > Project Settings > Autoload`, hitting the folder button and selecting `res://addons/event_bus/event_bus.tscn`. 
<br><br>

Then click the add button to add it! 

## Usage 
There are two ways any part of your code base will want to interact with the `EventBus`.
1. To **broadcast** an event (inform listeners in the game that something happened).
2. To **subscribe** to an event (to be informed when certain events happen).

That basically looks like this:
```gdscript
# Broadcasting
EventBus.service().broadcast(<Event>)

# Subscribing
EventBus.service().subscribe(<Event ID>, <Subscriber>, <Function Name>)
```

But we can look at some simple examples with a little more detail.

### Broadcasting
To broadcast an event, its as simple as:
```gdscript
func _something_cool_happened():
    var event = Event.new("COOL_EVENT_ID")
    EventBus.service().broadcast(event)
```

You can also subclass `Event` with more information-rich objects and broadcast them the same way. Let's imagine we have an `Event` object that has information about a player's health changing.

```gdscript
extends Node
class_name Player


func take_damage(dmg: float):
    var old_health = health.value
    health.value -= dmg
    var new_health = health.value

    var health_event = HealthEvent.new(old_health, new_health)
    EventBus.service().broadcast(event)


# Defining our custom Player.HealthEvent
class HealthEvent extends Event
    var old_health: float
    var new_health: float

    const ID = "HEALTH_EVENT_ID"

    # this passes in ID to the base `Event` _init
    func _init(old_value: float, new_value: float).(ID):
        self.old_health = old_value
        self.new_health = new_value

```

### Subscribing
To subscribe to an event, all you need to know about the `Event` you want to subscribe to is the `event_id`.

Subscribing takes 3 arguments:
1. `event_id`: the id of the event you care about
2. `subscriber`: the object/node that will respond to the event
3. `function_name`: the function that will be called in response to the event. 

It's almost identical to connecting a `signal`.

Let's see what that might look like in the simplest case:

```gdscript
func _ready():
    EventBus.service().subscribe("COOL_EVENT_ID",
            self, 
            "_on_cool_happenings")


func _on_cool_happenings(event: Event):
    print("Some cool event happened!")
```

All `Event` callbacks will be handed an `Event` object. 

In the case that you are listening for a specific `Event` subclass, you can use the `as` keyword to see if the `Event` meets your subclass criteria and then get the speicific properties you need from it. 

```gdscript
func _ready():
    EventBus.service().subscribe(Player.HealthEvent.ID,
            self, 
            "_on_player_health_event")


func _on_player_health_event(event: Event):
    var player_health_event = event as Player.HealthEvent
    if player_health_event:
        print(str(player_health_event.old_value))
        print(str(player_health_event.new_value))
```

## Other Examples
But don't just take my word for it! Here are some other Godot-focused `EventBus` implementations I found when poking around. If my version doesn't click for you maybe theirs will. 

- [naata - Godot Event Bus](https://github.com/Naata/godot-event-bus)
- [mikica1986vee - EventBus for Godot Engine](https://github.com/mikica1986vee/EventBus_for_Godot_engine)
- [fwerner13 - Godot Event Bus](https://github.com/fwerner13/godot-event-bus)
- [Edearth - Godot Event Bus Sample](https://github.com/Edearth/godot-event-bus-sample)
- [ridvandongelci - Godot Bridge for Android](https://github.com/ridvandongelci/GodotBridge)
- [loteque - Event Singleton Demo](https://github.com/loteque/event-singleton-demo)

## Contributing
Pull Requests are welcome, though I imagine major changes to the implementation will mostly live as other examples (such as a C# implementation). 


## License
[MIT](https://choosealicense.com/licenses/mit/)