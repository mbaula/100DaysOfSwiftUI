# Notes

### for loops
- for loops:
```
let platforms = ["iOS", "macOS", "tvOS", "watchOS"]

for os in platforms {
    print("Swift works great on \(os).")
}
```
- nested loops:
```
for i in 1...12 {
    print("The \(i) times table:")

    for j in 1...12 {
        print("  \(j) x \(i) is \(j * i)")
    }

    print()
}
```
- counting from 1,2,3,4:
```
for i in 1..<5 {
    print("Counting 1 up to 5: \(i)")
}
```
- you don't need to use i, or j as the loop variable, for example:
```
var lyric = "Haters gonna"

for _ in 1...5 {
    lyric += " hate"
}

print(lyric)
```

### While loop
- basic while loop:
```
var countdown = 10

while countdown > 0 {
    print("\(countdown)…")
    countdown -= 1
}

print("Blast off!")
```

### Skipping loop items with break and continue
- using continue is used so the rest of the loop body is skipped:
```
let filenames = ["me.jpg", "work.txt", "sophie.jpg", "logo.psd"]

for filename in filenames {
    if filename.hasSuffix(".jpg") == false {
        continue
    }

    print("Found picture: \(filename)")
}
```
- using break exits a loop immediately and skips all the remaining iterations
- So, use continue when you want to skip the rest of the current loop iteration, and use break when you want to skip all remaining loop iterations