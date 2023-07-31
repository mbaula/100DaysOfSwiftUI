# Notes

### Ordered data in arrays

- ``` var beatles = ["John", "Paul", "George", "Ringo"] ``` 
- ``` let numbers = [4, 8, 15, 16, 23, 42] ``` 
- ``` var temperatures = [25.3, 28.2, 26.4] ```
- you can use ***append()*** to modify an array after creating it
- you are not allowed to have multiply data types in an array for example you cannot append "Chris" to the temperatures array
- you can specialize the data type of an array by assigning a type to it:
    - ``` var scores = Array<Int>()```
- you can use ***.count*** to read how many items are in an array
- you can use ***remove(at: )*** to remove an item at a specific index, or removeAll() to remove everything
- you can check if an array contains a specific item using ***contains()***
- you can use ***.sorted()*** to sort an array in ascending order
- you can use ***.reversed()*** to reverse an array

### Dictionaries

- ``` let employee2 = ["name": "Taylor Swift", "job": "Singer", "location": "Nashville"] ```
- if a value doesn't exist you can provide a default value to use:
```
print(employee2["name", default: "Unknown"]) 
print(employee2["job", default: "Unknown"]) 
print(employee2["location", default: "Unknown"]) 
```
- the keys and values can be different data types
- You can also create an empty dictionary using whatever explicit types you want to store, then set keys one by one:
```
var heights = [String: Int]()
heights["Yao Ming"] = 229
heights["Shaquille O'Neal"] = 216
heights["LeBron James"] = 206
```
- dictionaries cannot allow duplicate keys to exist, if you try to set a value for a key that already exists, Swift will overwrite the previous value
- ***count and removeAll()*** exists for dictionaries

### Sets

- similar to arrays, but you cannot add duplicate items, and they don't store their items in particular order
```
let people = Set(["Denzel Washington", "Tom Cruise", "Nicolas Cage", "Samuel L Jackson"])
```
- sets do not care what order its items come in
- when adding items to a set you must use the following code:
```
var people = Set<String>()
people.insert("Denzel Washington")
people.insert("Tom Cruise")
people.insert("Nicolas Cage")
people.insert("Samuel L Jackson")
```
note how we use insert instead of append
- sets are useful in particular situations where we want to store data that has no duplicates, and the order does not matter. Sets allow otherwise slowcode like ***contains*** to run in no time at all.

### Enums

- 
```
enum Weekday {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
}
```
- you can now use the enum instead of strings:
```
var day = Weekday.monday
day = Weekday.tuesday
day = Weekday.friday
```