import UIKit


//: ## 1. Create custom types to represent an Airport Departures display
//: ![Airport Departures](matthew-smith-5934-unsplash.jpg)
//: Look at data from [Departures at JFK Airport in NYC](https://www.airport-jfk.com/departures.php) for reference.
//:
//: a. Use an `enum` type for the FlightStatus (En Route, Scheduled, Canceled, Delayed, etc.)
//:
//: b. Use a struct to represent an `Airport` (Destination or Arrival)
//:
//: c. Use a struct to represent a `Flight`.
//:
//: d. Use a `Date?` for the departure time since it may be canceled.
//:
//: e. Use a `String?` for the Terminal, since it may not be set yet (i.e.: waiting to arrive on time)
//:
//: f. Use a class to represent a `DepartureBoard` with a list of departure flights, and the current airport
enum FlightStatus : String {
    case enRoute = "enRoute"
    case scheduled = "scheduled"
    case canceled = "canceled"
    case delayed = "delayed"
    
}


struct Airport {
    let name: String
    let code: String
}


struct Flight {
    var depatureTime: Date?
    var terminal: String?
    var status: FlightStatus
    var destination: Airport
    var airline: String
    var flightNumber: String
    
}

class DepartureBoard {
    var airport: Airport
    var flights: [Flight]
    
    init(name: String, code: String){
        airport = Airport(name: name, code: code)
        flights = []
    }
    
    func alertMessage(depatureBoard: DepartureBoard){
        for flight in depatureBoard.flights {
            if flight.status == .canceled {
                print("We're sorry your flight to \(flight.destination) was canceled, here is a $500 voucher.")
            } else if flight.status == .scheduled {
                print("Your flight to \(flight.destination)  is scheduled to depart at \(flight.depatureTime) from terminal \(flight.terminal)")
            } else if flight.status == .enRoute {
                print("Your flight is in route, please head to terminal \(flight.terminal).")
            } else if flight.depatureTime == nil || flight.terminal == nil {
                print("TBD")
            }
        }

    }
    
}





//: ## 2. Create 3 flights and add them to a departure board
//: a. For the departure time, use `Date()` for the current time
//:
//: b. Use the Array `append()` method to add `Flight`'s
//:
//: c. Make one of the flights `.canceled` with a `nil` departure time
//:
//: d. Make one of the flights have a `nil` terminal because it has not been decided yet.
//:
//: e. Stretch: Look at the API for [`DateComponents`](https://developer.apple.com/documentation/foundation/datecomponents?language=objc) for creating a specific time
var airportOne = Airport(name: "John F Kennedy", code: "JFK")
var airportTwo = Airport(name: "Salt Lake City", code: "SLC")
var airportThree = Airport(name: "Rio de Janeiro", code: "GAL")

var flightOne = Flight(depatureTime: Date(), terminal: "1A", status: .scheduled, destination: airportOne, airline: "Delta", flightNumber: "1")
var flightTwo = Flight(depatureTime: Date(), terminal: "1B", status: .canceled, destination: airportTwo, airline: "American Airlines", flightNumber: "2")
var flightThree = Flight(depatureTime: Date(), terminal: nil, status: .delayed, destination: airportThree, airline: "SouthWest", flightNumber: "3")

var depatureBoardOne = DepartureBoard(name: "New York", code: "JFK")
var mainDepartureBoard = DepartureBoard(name: "Los Angeles", code: "LAX")

depatureBoardOne.flights.append(flightOne)
depatureBoardOne.flights.append(flightTwo)
depatureBoardOne.flights.append(flightThree)


//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func printDepatures(depatureBoard: DepartureBoard){
    for flight in depatureBoard.flights {
        print(flight)
    }
}

printDepatures(depatureBoard: depatureBoardOne)



//: ## 4. Make a second function to print print an empty string if the `departureTime` is nil
//: a. Createa new `printDepartures2(departureBoard:)` or modify the previous function
//:
//: b. Use optional binding to unwrap any optional values, use string interpolation to turn a non-optional date into a String
//:
//: c. Call the new or udpated function. It should not print `Optional(2019-05-30 17:09:20 +0000)` for departureTime or for the Terminal.
//:
//: d. Stretch: Format the time string so it displays only the time using a [`DateFormatter`](https://developer.apple.com/documentation/foundation/dateformatter) look at the `dateStyle` (none), `timeStyle` (short) and the `string(from:)` method
//:
//: e. Your output should look like:
//:
//:     Destination: Los Angeles Airline: Delta Air Lines Flight: KL 6966 Departure Time:  Terminal: 4 Status: Canceled
//:     Destination: Rochester Airline: Jet Blue Airways Flight: B6 586 Departure Time: 1:26 PM Terminal:  Status: Scheduled
//:     Destination: Boston Airline: KLM Flight: KL 6966 Departure Time: 1:26 PM Terminal: 4 Status: Scheduled
func printDepartures2(departureBoard: DepartureBoard) {
    
    
    for flight in departureBoard.flights {
        
        var depatureString: String = ""
        
        if let depatureTime = flight.depatureTime {
            
            depatureString = "\(depatureTime)"
        }
        
        var terminalString: String = ""
        
        if let departureTerminal = flight.terminal {
            terminalString = "\(departureTerminal)"
        }
        
        print("Destination: \(flight.destination.name) Flight: \(flight.flightNumber) Depature Time: \(depatureString) Terminal: \(terminalString) Status: \(flight.status)")

    }
    
        
}

printDepartures2(departureBoard: depatureBoardOne)

//: ## 5. Add an instance method to your `DepatureBoard` class (above) that can send an alert message to all passengers about their upcoming flight. Loop through the flights and use a `switch` on the flight status variable.
//: a. If the flight is canceled print out: "We're sorry your flight to \(city) was canceled, here is a $500 voucher"
//:
//: b. If the flight is scheduled print out: "Your flight to \(city) is scheduled to depart at \(time) from terminal: \(terminal)"
//:
//: c. If their flight is boarding print out: "Your flight is boarding, please head to terminal: \(terminal) immediately. The doors are closing soon."
//:
//: d. If the `departureTime` or `terminal` are optional, use "TBD" instead of a blank String
//:
//: e. If you have any other cases to handle please print out appropriate messages
//:
//: d. Call the `alertPassengers()` function on your `DepartureBoard` object below
//:
//: f. Stretch: Display a custom message if the `terminal` is `nil`, tell the traveler to see the nearest information desk for more details.
mainDepartureBoard.alertMessage(depatureBoard: depatureBoardOne)




//: ## 6. Create a free-standing function to calculate your total airfair for checked bags and destination
//: Use the method signature, and return the airfare as a `Double`
//:
//:     func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
//:     }
//:
//: a. Each bag costs $25
//:
//: b. Each mile costs $0.10
//:
//: c. Multiply the ticket cost by the number of travelers
//:
//: d. Call the function with a variety of inputs (2 bags, 2000 miles, 3 travelers = $750)
//:
//: e. Make sure to cast the numbers to the appropriate types so you calculate the correct airfare
//:
//: f. Stretch: Use a [`NumberFormatter`](https://developer.apple.com/documentation/foundation/numberformatter) with the `currencyStyle` to format the amount in US dollars.
func calculateAirfare(checkedBags: Int, distance: Double, travelers: Int) -> Double {
    
    let total = (Double(checkedBags) * 25 + Double(distance) * 0.1) * Double(travelers)
    
    return total
}

calculateAirfare(checkedBags: 2, distance: 2000, travelers: 3)
