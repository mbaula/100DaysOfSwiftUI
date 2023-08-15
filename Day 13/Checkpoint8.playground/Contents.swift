import UIKit

protocol Building {
    var rooms: Int {get}
    var cost: Int {get set}
    var stateAgent: String {get set}
}

extension Building {
    func printBuilding() {
        print("The building has \(rooms) rooms, costs \(cost), and is listed by \(stateAgent)")
    }
}

struct House: Building {
    var rooms: Int
    var cost: Int
    var stateAgent: String
}

struct Office: Building {
    var rooms: Int
    var cost: Int
    var stateAgent: String
}

let house = House(rooms: 4, cost: 500000, stateAgent: "Mark B")
house.printBuilding()

let office = Office(rooms: 50, cost: 1000000, stateAgent: "Xavier S")
office.printBuilding()
