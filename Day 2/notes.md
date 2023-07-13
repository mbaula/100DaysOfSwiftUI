# Notes

### Booleans
- Assigning booleans looks like this:
``` 
let goodDogs = true
let gameOver = false
```
- you can flip a boolean's value:
```
var isAuthenticated = false
isAuthenticated = !isAuthenticated
print(isAuthenticated)
isAuthenticated = !isAuthenticated
print(isAuthenticated)
```
- you can also use .toggle() on boolean to flip values

### Joining Strings
- can join strings using '+' or a technique called string interpolation.
- using '+' signs can be seen as wasteful and string interpolation is more efficient. it can be implemented like this:
```
let name = "Taylor"
let age = 26
let message = "Hello, my name is \(name) and I'm \(age) years old."
print(message)
```
- you cannot add integers to strings but you can cast the integer to a string and then add it. still you should use string interpolation
- you can also put calculations inside string interpolation if necessary

### Review
- Swift lets us create constants using let, and variables using var.
- If you don’t intend to change a value, make sure you use let so that Swift can help you avoid mistakes.
- Swift’s strings contain text, from short strings up to whole novels. They work great with emoji and any world language, and have helpful functionality such as count and uppercased().
- You create strings by using double quotes at the start and end, but if you want your string to go over several lines you need to use three double quotes at the start and end.
- Swift calls its whole numbers integers, and they can be positive or negative. They also have helpful functionality, such as isMultiple(of:).
- In Swift decimal numbers are called Double, short for double-length floating-point number. - That means they can hold very large numbers if needed, but they also aren’t 100% accurate – you shouldn’t use them when 100% precision is required, such as when dealing with money.
- There are lots of built-in arithmetic operators, such as +, -, *, and /, along with the special compound assignment operators such as += that modify variables directly.
- You can represent a simple true or false state using a Boolean, which can be flipped using the ! operator or by calling toggle().
- String interpolation lets us place constants and variables into our strings in a streamlined, efficient way.