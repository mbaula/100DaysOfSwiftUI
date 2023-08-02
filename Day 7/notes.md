# Notes

### Functions 

- basic function example:
```
func showWelcome() {
    print("Welcome to my app!")
    print("By default This prints out a conversion")
    print("chart from centimeters to inches, but you")
    print("can also set a custom range if you want.")
}
```
- examples of parameters:
```
func printTimesTables(number: Int) {
    for i in 1...12 {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(number: 5)
```
or
```
func printTimesTables(number: Int, end: Int) {
    for i in 1...end {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(number: 5, end: 20)
```
- you must always pass the parameters in the order they were listed when you created the function

### returning multiple values from functions
- when you want to return a single value from a function you write arrow and a data type before your function's opening brace:
```
func isUppercase(string: String) -> Bool {
    string == string.uppercased()
}
```
- if you want to return two or more values, you can use an array:
```
func getUser() -> [String] {
    ["Taylor", "Swift"]
}

let user = getUser()
print("Name: \(user[0]) \(user[1])") 
```

or a dictionary:

```
func getUser() -> [String: String] {
    [
        "firstName": "Taylor",
        "lastName": "Swift"
    ]
}

let user = getUser()
print("Name: \(user["firstName", default: "Anonymous"]) \(user["lastName", default: "Anonymous"])") 
```

- however these solutions are not ideal, luckily we can use tuples instead.
```
func getUser() -> (firstName: String, lastName: String) {
    (firstName: "Taylor", lastName: "Swift")
}

let user = getUser()
print("Name: \(user.firstName) \(user.lastName)")
```
- tuples have a key advantage over dictionaries: we specify exactly which values will exist and what types they have, whereas dictionaries may or may not contain the values we’re asking for

- example:
```
func square(_ number: Int) -> Int {
	return number * number
}
```