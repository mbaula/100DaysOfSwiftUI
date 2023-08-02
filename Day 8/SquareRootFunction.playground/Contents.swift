import UIKit

enum SquareRootFunctionError: Error {
    case outOfBounds, noRootFound
}

func checkSquareRoot(number: Int) throws -> String {
    if(number < 1 || number > 10000)
    {
        throw SquareRootFunctionError.outOfBounds
    }
    
    var count = 0
    
    while count*count < 10000 {
        if(count*count == number) {
            return("The square root of \(number) is \(String(count))")
        }
        
        count+=1
    }
    
    throw SquareRootFunctionError.noRootFound
}

do {
    let result = try checkSquareRoot(number: 57600)
    print("\(result)")
} catch SquareRootFunctionError.outOfBounds {
    print("Out of Bounds Error")
} catch SquareRootFunctionError.noRootFound {
    print("No Square Root was found")
} catch {
    print("There was an error.")
}
