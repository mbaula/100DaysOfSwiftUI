# Notes

### Creating our own structs
- Structs allows for creation of custom, complex data types, complete w/ their own variables and their own functions. A simple struct looks like:
```
struct Album {
    let title: String
    let artist: String
    let year: Int

    func printSummary() {
        print("\(title) (\(year)) by \(artist)")
    }
}
```
- We can make albums like:
```
let red = Album(title: "Red", artist: "Taylor Swift", year: 2012)
let wings = Album(title: "Wings", artist: "BTS", year: 2016)

print(red.title)
print(wings.artist)

red.printSummary()
wings.printSummary()
```
- if we have function that change data they must be marked with a special mutating keyword like this:
``` mutating func takeVacation(days: Int) { ```
- however note that we can't call a mutating function on a constant struct, which isn't allowed
- let's give some names to things:
    - Variables and constants that belong to structs are called properties.
    - Functions that belong to structs are called methods.
    - When we create a constant or variable out of a struct, we call that an instance – you might create a dozen unique instances of the Album struct, for example.
    - When we create instances of structs we do so using an initializer like this: Album(title: "Wings", artist: "BTS", year: 2016).
- these two pieces of code are the same:
```
var archer1 = Employee(name: "Sterling Archer", vacationRemaining: 14)
var archer2 = Employee.init(name: "Sterling Archer", vacationRemaining: 14)
```

### How to compute property values dynamically
- Structs have two kinds of properties, a stored property and a computed property
- 
```
var vacationRemaining: Int {
    get {
        vacationAllocated - vacationTaken
    }

    set {
        vacationAllocated = vacationTaken + newValue
    }
}
```
get and set mark individual pieces of code to run when reading or writing a value. More importantly, notice newValue – that’s automatically provided to us by Swift, and stores whatever value the user was trying to assign to the property.

With both a getter and setter in place, we can now modify vacationRemaining:
```
var archer = Employee(name: "Sterling Archer", vacationAllocated: 14)
archer.vacationTaken += 4
archer.vacationRemaining = 5
print(archer.vacationAllocated)
```

### How to take action when a property changes
- Swift lets us create property observers, which is code that run whne properties change. They take two forms:
    - didSet observer to run when property just changed
    - willSet observer to run before the property changed
- here's an example of a property observer in place:
```
struct Game {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

var game = Game()
game.score += 10
game.score -= 3
game.score += 1
```
```
struct App {
    var contacts = [String]() {
        willSet {
            print("Current value is: \(contacts)")
            print("New value will be: \(newValue)")
        }

        didSet {
            print("There are now \(contacts.count) contacts.")
            print("Old value was \(oldValue)")
        }
    }
}

var app = App()
app.contacts.append("Adrian E")
app.contacts.append("Allen W")
app.contacts.append("Ish S")
```
- willSet is used much less than didSet
- try to avoid putting too much work into property observers, it can cause all sorts of performance problems

### How to create custom initializers
- initializers are specialized methods designed to prepare a new struct instance to be used. all properties must have a value by the time the initializer ends.
- 
```
struct Player {
    let name: String
    let number: Int

    init(name: String, number: Int) {
        self.name = name
        self.number = number
    }
}
```
- 
    1. There is no func keyword. Yes, this looks like a function in terms of its syntax, but Swift treats initializers specially.
    2. Even though this creates a new Player instance, initializers never explicitly have a return type – they always return the type of data they belong to.
    3. I’ve used self to assign parameters to properties to clarify we mean “assign the name parameter to my name property”.
- custom initializers don't need to work like default initializers, for example we can randomize a value:
```
struct Player {
    let name: String
    let number: Int

    init(name: String) {
        self.name = name
        number = Int.random(in: 1...99)
    }
}

let player = Player(name: "Megan R")
print(player.number)
```
- as soon as we implement our own custom initializer we lose access to Swift's default initializer