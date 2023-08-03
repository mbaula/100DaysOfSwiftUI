# Notes

### Creating and using closures
- if you wanted to skip creating a separate function, and assign functionality directly to a constant or variable:
```
let sayHello = {
    print("Hi there!")
}

sayHello()
```
this is a closure expression, a chunk of code that we can pass around and call whatever we want
- if we want closures to accept parameters they must be written in a special way:
```
let sayHello = { (name: String) -> String in
    "Hi \(name)!"
}
```
the keyword in is used to mark the end of the parameters and return type
- ```var greetCopy: () -> Void = greetUser```
    1. The empty parentheses marks a function that takes no parameters.
    2. The arrow means just what it means when creating a function: we’re about to declare the return type for the function.
    3. Void means “nothing” – this function returns nothing. Sometimes you might see this written as (), but we usually avoid that because it can be confused with the empty parameter list.
- external parameter names only matter when we’re calling a function directly, not when we create a closure or when we take a copy of the function first
- so we've covered two different things:
    1. first, we can create closures as anonymous functions, storing them inside constants and variables:
    ```
    let sayHello = {
        print("Hi there!")
    }

    sayHello()
    ```
    2. we're able to pass functions into other functions, like passing captainFirstSorted() into sorted():
    ```
    let captainFirstTeam = team.sorted(by: captainFirstSorted)
    ```
- with closures we can put these two together, so here's the code that calls sorted() using a closure:
```
let captainFirstTeam = team.sorted(by: { (name1: String, name2: String) -> Bool in
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }

    return name1 < name2
})
```
- to explain the code above ^:
    1. We’re calling the sorted() function as before.
    2. Rather than passing in a function, we’re passing a closure – everything from the opening brace after by: down to the closing brace on the last line is part of the closure.
    3. Directly inside the closure we list the two parameters sorted() will pass us, which are two strings. We also say that our closure will return a Boolean, then mark the start of the closure’s code by using in.
    4. Everything else is just normal function code.

### Trailing closures and shorthand syntax
- if you remember sorted() can accept any kind of function to do custom sorting, with one rule: that function must accept two items from the array in question (that’s two strings here), and return a Boolean set to true if the first string should be sorted before the second.
- swift allows special syntax called trailing closure syntax, that transforms code to:
    1. 
    ```
    let team = ["Gloria", "Suzanne", "Piper", "Tiffany", "Tasha"]

    let captainFirstTeam = team.sorted(by: { (name1: String, name2: String) -> Bool in
        if name1 == "Suzanne" {
            return true
        } else if name2 == "Suzanne" {
            return false
        }

        return name1 < name2
    })

    print(captainFirstTeam)
    ```
    2. 
    ```
    let captainFirstTeam = team.sorted { name1, name2 in
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }

    return name1 < name2
    }
    ```
- There’s one last way Swift can make closures less cluttered: Swift can automatically provide parameter names for us, using shorthand syntax. With this syntax we don’t even write name1, name2 in any more, and instead rely on specially named values that Swift provides for us: $0 and $1, for the first and second strings respectively.

Using this syntax our code becomes even shorter: 
```
let captainFirstTeam = team.sorted {
if $0 == "Suzanne" {
    return true
} else if $1 == "Suzanne" {
    return false
}

return $0 < $1
}
```
- you can use shorthand syntax unless any of the following are true:
    1. The closure’s code is long.
    2. $0 and friends are used more than once each.
    3. You get three or more parameters (e.g. $2, $3, etc).
- some more examples of the usefulness of closures include:
```
let tOnly = team.filter { $0.hasPrefix("T") }
print(tOnly)
```
and
```
let uppercaseTeam = team.map { $0.uppercased() }
print(uppercaseTeam)
```

### How to accept functions as parameters
- here's a function that generates an array of integers by repeating a function a certain number of times:
```
func makeArray(size: Int, using generator: () -> Int) -> [Int] {
    var numbers = [Int]()

    for _ in 0..<size {
        let newNumber = generator()
        numbers.append(newNumber)
    }

    return numbers
}
```
- breaking that down:
    1. The function is called makeArray(). It takes two parameters, one of which is the number of integers we want, and also returns an array of integers.
    2. The second parameter is a function. This accepts no parameters itself, but will return one integer every time it’s called.
    3. Inside makeArray() we create a new empty array of integers, then loop as many times as requested.
    4. Each time the loop goes around we call the generator function that was passed in as a parameter. This will return one new integer, so we put that into the numbers array.
    5. Finally the finished array is returned.
- The body of the makeArray() is mostly straightforward: repeatedly call a function to generate an integer, adding each value to an array, then send it all back. The complex part is the very first line:
```
func makeArray(size: Int, using generator: () -> Int) -> [Int] 
```
- There we have two sets of parentheses and two sets of return types, so it can be a bit of a jumble at first. If you split it up you should be able to read it linearly:

    1. We’re creating a new function.
    2. The function is called makeArray().
    3. The first parameter is an integer called size.
    4. The second parameter is a function called generator, which itself accepts no parameters and returns an integer.
    5. The whole thing – makeArray() – returns an array of integers.
- you can make your function accept multiple function parameters if you want:
```
func doImportantWork(first: () -> Void, second: () -> Void, third: () -> Void) {
    print("About to start first work")
    first()
    print("About to start second work")
    second()
    print("About to start third work")
    third()
    print("Done!")
}
```
or alternatively it can be written like:
```
doImportantWork {
    print("This is the first work")
} second: {
    print("This is the second work")
} third: {
    print("This is the third work")
}
```

