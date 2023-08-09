# Notes

### How to create and use protocols
- Protocols are like contracts in Swift, they let us define what functionality we expect a data type to support, and Swift ensures the rest of our code follows the rules.
- think about writing code to simulate someone's commute from home to office it might look like these:
```
func commute(distance: Int, using vehicle: Car) {
    // lots of code here
}

func commute(distance: Int, using vehicle: Train) {
    // lots of code here
}

func commute(distance: Int, using vehicle: Bus) {
    // lots of code here
}
```
- we don’t actually care how the underlying trip happens. What we care about is much broader: how long might it take for the user to commute using each option, and how to perform the actual act of moving to the new location.
- protocols let us define properties and methods we want to use. they do not implement them though. a new Vehicle protocol can look like this:
```
protocol Vehicle {
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}
```
- Let’s break that down:
    1. To create a new protocol we write protocol followed by the protocol name. This is a new type, so we need to use camel case starting with an uppercase letter.
    2. Inside the protocol we list all the methods we require in order for this protocol to work the way we expect.
    3. These methods do not contain any code inside – there are no function bodies provided here. Instead, we’re specifying the method names, parameters, and return types. You can also mark methods as being throwing or mutating if needed.
- We can now design types that work with that protocol, it specifies only a bare minimum not a full range. For example, a Car struct that conforms to the Vehicle protocol can look like this:
```
struct Car: Vehicle {
    func estimateTime(for distance: Int) -> Int {
        distance / 50
    }

    func travel(distance: Int) {
        print("I'm driving \(distance)km.")
    }

    func openSunroof() {
        print("It's a nice day!")
    }
}
```
- let's draw attention to:
    1. We tell Swift that Car conforms to Vehicle by using a colon after the name Car, just like how we mark subclasses.
    2. All the methods we listed in Vehicle must exist exactly in Car. If they have slightly different names, accept different parameters, have different return types, etc, then Swift will say we haven’t conformed to the protocol.
    3. The methods in Car provide actual implementations of the methods we defined in the protocol. In this case, that means our struct provides a rough estimate for how many minutes it takes to drive a certain distance, and prints a message when travel() is called.
    4. The openSunroof() method doesn’t come from the Vehicle protocol, and doesn’t really make sense there because many vehicle types don’t have a sunroof. But that’s okay, because the protocol describes only the minimum functionality conforming types must have, and they can add their own as needed.
- To finish off, let’s update the commute() function from earlier so that it uses the new methods we added to Car:
```
func commute(distance: Int, using vehicle: Car) {
    if vehicle.estimateTime(for: distance) > 100 {
        print("That's too slow! I'll try a different vehicle.")
    } else {
        vehicle.travel(distance: distance)
    }
}

let car = Car()
commute(distance: 100, using: car)
```
- Swift knows that any type conforming to Vehicle must implement both estimateTime() and travel() methods, and so it actually lets us use Vehicle as the type of our parameter rather than Car. We can rewrite the function to this:
```
func commute(distance: Int, using vehicle: Vehicle) {
```

- Now we say this function can be called with any type of data, as long as the type conforms to the Vehicle protocol.
- Rather than saying this parameter must be a car, we can say this parameter can be anything at all, as long as it's able to estimate travel time and move to a new location.
- you can specify properties that must exist on conforming types as well:
```
protocol Vehicle {
    var name: String { get }
    var currentPassengers: Int { get set }
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}
```
- You can conform to as many protocols as you need, just by listing them one by one separated with a comma. If you ever need to subclass something and conform to a protocol, you should put the parent class name first, then write your protocols afterwards.

### How to use opaque return types
- to start let's implement two simple functions:
```
func getRandomNumber() -> Int {
    Int.random(in: 1...6)
}

func getRandomBool() -> Bool {
    Bool.random()
}
```
- Both Int and Bool conform to a common Swift protocol called Equatable, which means “can be compared for equality.” The Equatable protocol is what allows us to use ==, like this:
```
print(getRandomNumber() == getRandomNumber())
```
- Because both of these types conform to Equatable, we could try amending our function to return an Equatable value, like this:
```
func getRandomNumber() -> Equatable {
    Int.random(in: 1...6)
}

func getRandomBool() -> Equatable {
    Bool.random()
}
```
- this code won't work,  “protocol 'Equatable' can only be used as a generic constraint because it has Self or associated type requirements”. What Swift’s error means is that returning Equatable doesn’t make sense, and understanding why it doesn’t make sense is the key to understanding opaque return types.
- you are able to return protocols from functions
- Returning a protocol from a function is useful because it lets us hide information: rather than stating the exact type that is being returned, we get to focus on the functionality that is returned. In the case of a Vehicle protocol, that might mean reporting back the number of seats, the approximate fuel usage, and a price. This means we can change our code later without breaking things: we could return a RaceCar, or a PickUpTruck, etc, as long as they implement the properties and methods required by Vehicle.
- Hiding information in this way is really useful, but it just isn’t possible with Equatable because it isn’t possible to compare two different Equatable things. Even if we call getRandomNumber() twice to get two integers, we can’t compare them because we’ve hidden their exact data type – we’ve hidden the fact that they are two integers that actually could be compared.
- This is where opaque return types come in: they let us hide information in our code, but not from the Swift compiler. This means we reserve the right to make our code flexible internally so that we can return different things in the future, but Swift always understands the actual data type being returned and will check it appropriately.
- To upgrade our two functions to opaque return types, add the keyword some before their return type, like this:
```
func getRandomNumber() -> some Equatable {
    Int.random(in: 1...6)
}

func getRandomBool() -> some Equatable {
    Bool.random()
}
```
- when you see some View in your SwiftUI code, it’s effectively us telling Swift “this is going to send back some kind of view to lay out, but I don’t want to write out the exact thing – you figure it out for yourself.”

### How to create and use extensions
- extensions let us add functionality to any type.
- say we wanted to trim characters, it's a bit wordy so let's make an extension to make it shorter:
```
extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
```
- breaking it down:
    1. We start with the extension keyword, which tells Swift we want to add functionality to an existing type.
    2. Which type? Well, that comes next: we want to add functionality to String.
    3. Now we open a brace, and all the code until the final closing brace is there to be added to strings.
    4. We’re adding a new method called trimmed(), which returns a new string.
    5. Inside there we call the same method as before: trimmingCharacters(in:), sending back its result.
    6. Notice how we can use self here – that automatically refers to the current string. This is possible because we’re currently in a string extension.
- now everywhere we want to remove the whitespace and new lines, we can write:
```
let trimmed = quote.trimmed()
```
- there are multiple benefits of using extensions over global functions:
    1. When you type quote. Xcode brings up a list of methods on the string, including all the ones we add in extensions. This makes our extra functionality easy to find.
    2. Writing global functions makes your code rather messy – they are hard to organize and hard to keep track of. On the other hand, extensions are naturally grouped by the data type they are extending.
    3. Because your extension methods are a full part of the original type, they get full access to the type’s internal data. That means they can use properties and methods marked with private access control, for example
- extensions also make it easier to modify values in place, rather than returning a new value
- if you want the ability to use a custom initializer, but also retain Swift's automatic memberwise initializer, we can implement the custom init inside an extension.
- if we want our Book struct to keep the memberwise initializer as well as our own custom init, place the custom one in an extension:
```
extension Book {
    init(title: String, pageCount: Int) {
        self.title = title
        self.pageCount = pageCount
        self.readingHours = pageCount / 50
    }
}
```

### How to create and use protocol extensions
- let's start with a trivial example, writing a condition checking whether an array has any values in:
```
let guests = ["Mario", "Luigi", "Peach"]

if guests.isEmpty == false {
    print("Guest count: \(guests.count)")
}
```
or using the Boolean ! operator:
```
if !guests.isEmpty {
    print("Guest count: \(guests.count)")
}
```
- we can fix this w/ a really simple extension for Array, like so:
```
extension Array {
    var isNotEmpty: Bool {
        isEmpty == false
    }
}
```
and so we can write code easier to understand:
```
if guests.isNotEmpty {
    print("Guest count: \(guests.count)")
}
```
- we can do better by accounting for sets and dictionaries
- Array, Set, and Dictionary all conform to a built-in protocol called Collection, through which they get functionality such as contains(), sorted(), reversed(), and more.
- This is important, because Collection is also what requires the isEmpty property to exist. So, if we write an extension on Collection, we can still access isEmpty because it’s required. This means we can change Array to Collection in our code to get this:
```
extension Collection {
    var isNotEmpty: Bool {
        isEmpty == false
    }
}
```
- by extending the protocol, we're adding functionality that would otherwise need to be done inside individual structs. we can list required methods in a protocol and then add default implementations inside a protocol extension. for example in a protocol such as this:
```
protocol Person {
    var name: String { get }
    func sayHello()
}
```
all conforming types must add a sayHello() method, but we can add a default implementation as an extension:
```
extension Person {
    func sayHello() {
        print("Hi, I'm \(name)")
    }
}
```
now conforming types can add their own sayHello() but they don't need to