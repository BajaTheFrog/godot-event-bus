# Godot Event Dispatch
A simple event bus / pubsub implementation with sample(s)

## TL;DR 
Here's code you can use to quickly set up an `Event Bus` in your game. 

If you don't know what an `Event Bus` is, or why you might want it. There are a lot of good resources you can find on the topic. 

But the short version is: to prevent making insane, unmanageable code, a _great pattern_ for disparate parts of your game to know about what's happening elsewhere is with `Events`. 

`Signals` are a _fantastic_ at the "local" level, they still require directly connecting from one node to another. 

This doesn't scale well as lots of things enter the fray. 


## Tell me more
Many Godot developers are familiar with the phrase:

> _"Call down, signal up"_

It's a helpful, catchy reminder and guidance about inter-node communication. 

**But** really it's advice that is best suited for direct parent-child node relationships. Maybe grandparents too. 

As more and more nodes and scenes enter your tree, you are asking for a headache if you are 

1. Directly calling down to some arbitrary scene 
2. Connecting signals between dynamically added scenes and lots of possible systems

So what if I told you there was a (not-so) secret, **third thing**?

`Events`. 

### A classic example
You are making a game. 
There is a `hero`. 
There is combat. 

You need the UI to display a healthbar that communicates how much health the `hero` has left. 

#### Call down
The health bar UI has to get, or be given, a reference to the `hero` and then check every frame to see what their health is. 
This is wasteful AND it makes it harder to build and debug the UI on its own because it _requires_ a `hero` to work. No good. 


#### Signal up
The health bar UI has to get, or be given, a reference to the `hero` and connects itself to a `signal` about health changes. This is an improvement as we no longer are checking every frame but the fact remains we still have to rely on a `hero` reference. 

And if we flipped the dependencies we would have the same problem where the `hero` would demand some access to the UI. 


#### Using events instead
By using `Events`, a `hero` can broadcast an `Event` much like they would trigger a `signal`. 

But now, the UI can register with the `Event Bus` to listen for `Events` with a speific ID (let's say `HERO_HEATH_EVENT`, as an example) without having to find a `hero` to directly hook up to. 

This removes an entire dependency concern and opens up the possibility of simulating events through hotkeys and debug tools. 

And its just as easy for an arbitrary number of other nodes and systems to listen to `HERO_HEATH_EVENT`s too. 

Want an enemy that gets stronger when the `hero` is weak? 
A chest that only unlocks when `hero` health is full? 

Easily implemented by subscribing without needing to guarantee a `hero` is ever in the scene. 


## Okay, show me how it works
Great. Happy to. 

This implementation uses an `Autoload` called `EventDispatch`. 

