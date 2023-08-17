import SwiftUI

func getRandomNumber(from array: [Int]? = nil) -> Int { array?.randomElement() ?? Int.random(in: 1...100) }

getRandomNumber(from: [10,1,5,6,99])
getRandomNumber()
