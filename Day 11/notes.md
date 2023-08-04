# Notes

### How to limit access to internal data using access control
- sometimes you want to hide some data from external access. demonstrating:
```
struct BankAccount {
    var funds = 0

    mutating func deposit(amount: Int) {
        funds += amount
    }

    mutating func withdraw(amount: Int) -> Bool {
        if funds >= amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}
```
- this has methods to deposit and withdraw money, should be used like this:
```
var account = BankAccount()
account.deposit(amount: 100)
let success = account.withdraw(amount: 200)

if success {
    print("Withdrew money successfully")
} else {
    print("Failed to get the money")
}
```
- however since the funds property is exposed externally, we can easily just mutate it directly which bypasses our logic for depositing and withdrawing. to solve this this, funds should only be accessible within the struct, and we can do this by:
``` private var funds = 0 ```
- this is called access control, because it controls how a struct's properties and methods can be accessed from outside the struct:
    - Use private for “don’t let anything outside the struct use this.”
    - Use fileprivate for “don’t let anything outside the current file use this.”
    - Use public for “let anyone, anywhere use this.”
- private(set). This means “let anyone read this property, but only let my methods write it.” If we had used that with BankAccount, it would mean we could print account.funds outside of the struct, but only deposit() and withdraw() could actually change the value.
- Important: If you use private access control for one or more properties, chances are you’ll need to create your own initializer.

### Static properties and methods
- simple example:
```
struct School {
    static var studentCount = 0

    static func add(student: String) {
        print("\(student) joined the school.")
        studentCount += 1
    }
}
```
- they are static, which means they don't exist uniquely on instances of the struct
- if you'd like to mix and match static and non-static properties, there are two rules:
    1. To access non-static code from static code… you’re out of luck: static properties and methods can’t refer to non-static properties and methods because it just doesn’t make sense – which instance of School would you be referring to?
    2. To access static code from non-static code, always use your type’s name such as School.studentCount. You can also use Self to refer to the current type.
