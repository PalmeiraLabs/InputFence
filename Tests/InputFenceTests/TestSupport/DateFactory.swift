import Foundation

enum DateFactory {
    static func date(day: Int, month: Int, year: Int) -> Date {
        var components = DateComponents()
        components.calendar = Calendar(identifier: .gregorian)
        components.timeZone = TimeZone(secondsFromGMT: 0)
        components.day = day
        components.month = month
        components.year = year
        components.hour = 12
        guard let date = components.date else {
            preconditionFailure("Invalid test fixture date")
        }
        return date
    }
}
