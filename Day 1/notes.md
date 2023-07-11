# Notes


### Creating Variables
- ***var*** is a keyword that allows us to create a new variable
- when you make a variable you can change it over time:
```
var name = "Mark"
name = "Ted"
name = "Seth" 
```
- if you do not want your variable to change value you can use constants instead with the ***let*** keyword.
- camel case convention is the standard amongst swift devs
- if you can try to use constants over variables

### Creating Strings
- ``` let actor = "Morgan Freeman" ```
- you can use double quotes inside the string using backslashes:

``` let quote = "let quote = "Then he tapped a sign saying \"Believe\" and walked away." ```
- for multi-line strings use three quotation marks, note that the final three quotation marks must be on a seperate line themselves
- you can see the length of a string: ``` actor.count ```
- you can get every letter in string to be uppercase ``` actor.uppercased() ```
- The last piece of helpful string functionality is called hasPrefix(), and lets us know whether a string starts with some letters of our choosing: ``` print(movie.hasPrefix("A day")) ```
- There’s also a hasSuffix() counterpart, which checks whether a string ends with some text: ``` print(filename.hasSuffix(".jpg")) ```

### Storing Numbers
- ``` let number = 10 ```
- ***+*** for addition, - for subtraction, * for multiplication, and / for division
- you can call isMultiple(of:) on an integer to find out whether it’s a multiple of another integer.

### Decimal Numbers
- when you create a floating-point number, Swift considers it to be a Double
- you cannot mix doubles and ints together
- you can typecast with Int() or Double()

