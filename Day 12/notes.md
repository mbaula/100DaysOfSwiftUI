# Notes

### How to create your own classes
- Similarity to structs:
    - You get to create and name them.
    - You can add properties and methods, including property observers and access control.
    - You can create custom initializers to configure new instances however you want.

- Difference in structs:
    1. You can make one class build upon functionality in another class, gaining all its properties and methods as a starting point. If you want to selectively override some methods, you can do that too.
    2. Because of that first point, Swift won’t automatically generate a memberwise initializer for classes. This means you either need to write your own initializer, or assign default values to all your properties.
    3. When you copy an instance of a class, both copies share the same data – if you change one copy, the other one also changes.
    4. When the final copy of a class instance is destroyed, Swift can optionally run a special function called a deinitializer.
    5. Even if you make a class constant, you can still change its properties as long as they are variables.

- SwiftUI uses classes extensively, mainly for point 3.
- The other points matter, but are of varying use:

    1. Being able to build one class based on another is really important in Apple’s older UI framework, UIKit, but is much less common in SwiftUI apps. In UIKit it was common to have long class hierarchies, where class A was built on class B, which was built on class C, which was built on class D, etc.
    2. Lacking a memberwise initializer is annoying, but hopefully you can see why it would be tricky to implement given that one class can be based upon another – if class C added an extra property it would break all the initializers for C, B, and A.
    3. Being able to change a constant class’s variables links in to the multiple copy behavior of classes: a constant class means we can’t change what pot our copy points to, but if the properties are variable we can still change the data inside the pot. This is different from structs, where each copy of a struct is unique and holds its own data.
    4. Because one instance of a class can be referenced in several places, it becomes important to know when the final copy has been destroyed. That’s where the deinitializer comes in: it allows us to clean up any special resources we allocated when that last copy goes away.

- Create a class using code like this:
```
class Game {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

var newGame = Game()
newGame.score += 10
```

### How to make one class inherit from the other
- To make one class inherit from another, write a colon after the child class’s name, then add the parent class’s name
- Here is an employee class:
```
class Employee {
    let hours: Int

    init(hours: Int) {
        self.hours = hours
    }
}
```
- We can make two subclasses of Employee, which will gain the hours property and initializer:
```
class Developer: Employee {
    func work() {
        print("I'm writing code for \(hours) hours.")
    }
}

class Manager: Employee {
    func work() {
        print("I'm going to meetings for \(hours) hours.")
    }
}
```
- Each of those classes inherit from Employee, but adds their own customization
- You can also share methods as well as properties:
```
func printSummary() {
    print("I work \(hours) hours a day.")
}
```
- Because Developer inherits from Employee, we can immediately start calling printSummary() on instances of Developer, like this:
```
let novall = Developer(hours: 8)
novall.printSummary()
```
- If a child wants to change a method from the parent class, you must override in the child class's version. This does:
    1. If you attempt to change a method without using override, Swift will refuse to build your code. This stops you accidentally overriding a method.
    2. If you use override but your method doesn’t actually override something from the parent class, Swift will refuse to build your code because you probably made a mistake.
- If we wanted developers to have unique printSummary() method, add this to the Developer class:
```
override func printSummary() {
    print("I'm a developer who will sometimes work \(hours) hours a day, but other times spend hours arguing about whether code should be indented using tabs or spaces.")
}
```
- if you know for sure that your class does not need support inheritance, mark it as ***final***

### How to add initializers to classes 
- let's start by defining a new class:
```
class Vehicle {
    let isElectric: Bool

    init(isElectric: Bool) {
        self.isElectric = isElectric
    }
}
```
- If we want a Car class to inherit from Vehicle class, here is how it would look:
```
class Car: Vehicle {
    let isConvertible: Bool

    init(isElectric: Bool, isConvertible: Bool) {
        self.isConvertible = isConvertible
        super.init(isElectric: isElectric)
    }
}
```
- Now that we have valid initializer in both our classes, we can make an instance of Car like so:
``` let teslaX = Car(isElectric: true, isConvertible: false) ```

### How to copy classes
- In Swift, all copies of a class instance share the samee data, meaning changes to once copy will change the other copies. All copies of class refer back to the same underlying pot of data.
```
class User {
    var username = "Anonymous"
}

var user1 = User()

var user2 = user1
user2.username = "Taylor"

print(user1.username)  
print(user2.username)
```

this will print "Taylor" for both, even though we only changed one instance, both were changed.
- in comparison structs do not share their data amongst copies
- if we want to create a unique copy of a class instance (sometimes called deep copy) you need to handle creating a new instance and copy all the data safely. here's how to do that:
```
class User {
    var username = "Anonymous"

    func copy() -> User {
        let user = User()
        user.username = username
        return user
    }
}
```
now we can safely call copy() to get an object with the same starting data, but future change won't impact the original

### How to create a deinitializer for a class
- the oppposite of an initializer, the object is destroyed when deinitializers are called. they come with a few rules:
    1. Just like initializers, you don’t use func with deinitializers – they are special.
    2. Deinitializers can never take parameters or return data, and as a result aren’t even written with parentheses.
    3. Your deinitializer will automatically be called when the final copy of a class instance is destroyed. That might mean it was created inside a function that is now finishing, for example.
    4. We never call deinitializers directly; they are handled automatically by the system.
    5. Structs don’t have deinitializers, because you can’t copy them.
- these are called depending on the scope: "the context where information is available": 
    - If you create a variable inside a function, you can’t access it from outside the function.
    - If you create a variable inside an if condition, that variable is not available outside the condition.
    - If you create a variable inside a for loop, including the loop variable itself, you can’t use it outside the loop.
- conditions, loop, and functions all create local scopes.
- let's take a look at an example:
```
class User {
    let id: Int

    init(id: Int) {
        self.id = id
        print("User \(id): I'm alive!")
    }

    deinit {
        print("User \(id): I'm dead!")
    }
}

for i in 1...3 {
    let user = User(id: i)
    print("User \(user.id): I'm in control!")
}
```
- we can create and destroy instances of that quickly using a loop, if we create a User instance inside the loop, it's destroyed as soon as the loop iteration finishes. It creates and destroys each user individually, with one being destroyed fully before another is even created.
- in the following example, they will only be destroyed once the array is cleared:
```
var users = [User]()

for i in 1...3 {
    let user = User(id: i)
    print("User \(user.id): I'm in control!")
    users.append(user)
}

print("Loop is finished!")
users.removeAll()
print("Array is clear!")
```

### How to work with variables inside classes
- there are four options:
    1. Constant instance, constant property – a signpost that always points to the same user, who always has the same name.
    2. Constant instance, variable property – a signpost that always points to the same user, but their name can change.
    3. Variable instance, constant property – a signpost that can point to different users, but their names never change.
    4. Variable instance, variable property – a signpost that can point to different users, and those users can also change their names.
