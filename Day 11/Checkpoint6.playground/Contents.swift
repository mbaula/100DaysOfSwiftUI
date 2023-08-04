import UIKit

struct Car {
    let model: String
    let numOfSeats: Int
    private(set) var currentGear = 1
    
    mutating func gearUp() {
        if(currentGear < 11) {
            currentGear += 1
            print("Going up a gear! Current gear is: \(currentGear)")
        }
        else {
            print("Cannot go up a gear! Current gear is: \(currentGear)")
        }
    }
    
    mutating func gearDown() {
        if(currentGear > 1) {
            currentGear -= 1
            print("Going down a gear! Current gear is: \(currentGear)")
        }
        else {
            print("Cannot go down a gear! Current gear is: \(currentGear)")
        }
    }
    
    init(model: String, numOfSeats: Int) {
        self.model = model
        self.numOfSeats = numOfSeats
        self.currentGear = 1
    }
}

var car = Car.init(model: "Ford Shelby GT350", numOfSeats: 4)
car.gearUp()
car.gearUp()
car.gearUp()
car.gearDown()
car.gearDown()
car.gearDown()
print(car)
