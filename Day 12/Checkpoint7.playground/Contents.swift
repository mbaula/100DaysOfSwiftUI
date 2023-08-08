import UIKit

class Animals {
    let legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animals {
    init() {
        super.init(legs: 4)
    }
    
    func speak() {
        print("Woof Woof!")
    }
}

class Corgi: Dog {
    override func speak() {
        print("Barky Barky!")
    }
}

class Poodle: Dog {
    override func speak() {
        print("Haf Haf!")
    }
}

class Cat: Animals {
    func speak() {
        print("Meow Meow!")
    }
    
    let isTame: Bool
    
    init(isTame: Bool) {
        self.isTame = isTame
        super.init(legs: 4)
    }
}

class Persian: Cat {
    override func speak() {
        print("Omemeh Omemeh!")
    }
    
    init() {
        super.init(isTame: true)
    }
}

class Lion: Cat {
    override func speak() {
        print("ROAAAAAR!")
    }
    
    init() {
        super.init(isTame: false)
    }
}

let Eli = Corgi()
Eli.speak()
print(Eli.legs)

let Simba = Lion()
Simba.speak()
print(Simba.isTame)

let meower = Cat(isTame: false)
print(meower.legs)
