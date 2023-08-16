# Notes

### How to handle missing data w/ optionals
- Swift has a way of ensuring predictability called optionals - a thing might have a value or might not
```
let opposites = [
    "Mario": "Wario",
    "Luigi": "Waluigi"
]

let peachOpposite = opposites["Peach"]
```
- in this case peachOpposite would be a String? instead of a String. 
- there are two primary ways of unwrapping optionals, but common one looks like:
```
if let marioOpposite = opposites["Mario"] {
    print("Mario's opposite is \(marioOpposite)")
}
```
- This if let syntax is very common in Swift, and combines creating a condition (if) with creating a constant (let). Together, it does three things:
    1. It reads the optional value from the dictionary.
    2. If the optional has a string inside, it gets unwrapped – that means the string inside gets placed into the marioOpposite constant.
    3. The condition has succeeded – we were able to unwrap the optional – so the condition’s body is run.
- The condition's body will only be run if optional had value inside, you can also add an else block if the optional is empty:
```
var username: String? = nil

if let unwrappedName = username {
    print("We got a user: \(unwrappedName)")
} else {
    print("The optional was empty.")
}
```
- code like this will not work:
```
func square(number: Int) -> Int {
    number * number
}

var number: Int? = nil
print(square(number: number))
```
it needs to be unwrapped, so to use the optional it must be unwrapped like this:
```
if let unwrappedNumber = number {
    print(square(number: unwrappedNumber))
}
```
- note that we can unwrap them into constants of the same name, this is perfectly allowable in Swift, so you can write the previos code like this:
```
if let number = number {
    print(square(number: number))
}
```
this is called shadowing and mainly used with optional unwraps

### How to unwrap optionals with guard
- we already saw that we can use if let to unwrap optionals, but another way to do it is using guard let:
```
func printSquare(of number: Int?) {
    guard let number = number else {
        print("Missing input")
        return
    }

    print("\(number) x \(number) is \(number * number)")
}
```
it will check whether there is a value inside an optional, if there is it will retrieve the value and place it into a constant of our choosing. the way it does so flips things around:
```
var myVar: Int? = 3

if let unwrapped = myVar {
    print("Run if myVar has a value inside")
}

guard let unwrapped = myVar else {
    print("Run if myVar doesn't have a value inside")
}
```
if let runs code inside braces if optional had a value, guard let runs code inside if optional does not have a value
- 
    1. If you use guard to check a function’s inputs are valid, Swift will always require you to use return if the check fails.
    2. If the check passes and the optional you’re unwrapping has a value inside, you can use it after the guard code finishes.
```
func printSquare(of number: Int?) {
    guard let number = number else {
        print("Missing input")

        // 1: We *must* exit the function here
        return
    }

    // 2: `number` is still available outside of `guard`
    print("\(number) x \(number) is \(number * number)")
}
```
use if let to unwrap optionals so you can process them somehow, and use guard let to ensure optionals have something inside them and exit otherwise
- Tip: You can use guard with any condition, including ones that don’t unwrap optionals. For example, you might use guard someArray.isEmpty else { return }.

### How to unwrap optionals with nil coalescing
- another way to unwrap using the nil coalescing operator
- with his operator we can provide a default value for any optional, like this:
```
let new = captains["Serenity"] ?? "N/A"
```
- if the optional has a value it will be sent back and stored in new, if not "N/A" will be used instead
- this is the exact same result as setting a default value in the dictionary
- As you can see, the nil coalescing operator is useful anywhere you have an optional and want to use the value inside or provide a default value if it’s missing.

### How to handle multiple optionals using optional chaining
- optional chaining is simplified syntax for reading optionals inside optionals. look at this code:
```
let names = ["Arya", "Bran", "Robb", "Sansa"]

let chosen = names.randomElement()?.uppercased() ?? "No one"
print("Next in line: \(chosen)")
```
before the nil coalescing operator we see optional chaining where we have a question mark followed by more code
- optional chaining allows us to say if the optional has a value inside, unwrap it and then add more code (uppercase it)
- chains can go as long as you want, and as soon as any part sends back nil the rest of the line of code is ignored and sends back nil
- to show an extreme example:
```
struct Book {
    let title: String
    let author: String?
}

var book: Book? = nil
let author = book?.author?.first?.uppercased() ?? "A"
print(author)
```
- So, it reads “if we have a book, and the book has an author, and the author has a first letter, then uppercase it and send it back, otherwise send back A”.

### How to handle function failure with optionals
- when we call functions that might throw errors we use try and handle errors appropriately or try! if we're certain function will not fail.
- if all we care about is whether function succeeded or failed, we can use optionaly try to have function return an optional value
- example:
```
enum UserError: Error {
    case badID, networkFailed
}

func getUser(id: Int) throws -> String {
    throw UserError.networkFailed
}

if let user = try? getUser(id: 23) {
    print("User: \(user)")
}
```
- try? makes getUser() return an optional string which is nil if any errors are thrown
- If you want, you can combine try? with nil coalescing, which means “attempt to get the return value from this function, but if it fails use this default value instead.”
- be sure to add parentheses before nil coalescing so that Swift understands exactly what you mean:
```
let user = (try? getUser(id: 23)) ?? "Anonymous"
print(user)
```
- You’ll find try? is mainly used in three places:
    1. In combination with guard let to exit the current function if the try? call returns nil.
    2. In combination with nil coalescing to attempt something or provide a default value on failure.
    3. When calling any throwing function without a return value, when you genuinely don’t care if it succeeded or not – maybe you’re writing to a log file or sending analytics to a server, for example.