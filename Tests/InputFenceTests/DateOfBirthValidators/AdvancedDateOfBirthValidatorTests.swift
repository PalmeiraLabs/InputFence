import XCTest
@testable import InputFence

final class AdvancedDateOfBirthValidatorTests: XCTestCase {
    private let currentDate = DateFactory.date(day: 15, month: 7, year: 2026)

    func test_isValid_whenAgeIsInsideDefaultRange_returnsTrue() {
        let validator = makeValidator()

        XCTAssertTrue(validator.isValid("15/07/1996"))
    }

    func test_isValid_whenInputIsEmptyOrHasInvalidLength_returnsFalse() {
        let validator = makeValidator()

        XCTAssertFalse(validator.isValid(""))
        XCTAssertFalse(validator.isValid("01/01/20"))
    }

    func test_isValid_whenDateCannotBeParsed_returnsFalse() {
        let validator = makeValidator()

        XCTAssertFalse(validator.isValid("31/02/2000"))
    }

    func test_isValid_whenDateIsInFuture_returnsFalse() {
        let validator = makeValidator()

        XCTAssertFalse(validator.isValid("16/07/2026"))
    }

    func test_isValid_whenAgeIsBelowDefaultMinimum_returnsFalse() {
        let validator = makeValidator()

        XCTAssertFalse(validator.isValid("16/07/2008"))
    }

    func test_isValid_whenAgeIsAboveDefaultMaximum_returnsFalse() {
        let validator = makeValidator()

        XCTAssertFalse(validator.isValid("14/07/1905"))
    }

    func test_isValid_whenCustomAgeRangeIsProvided_appliesCustomRange() {
        let parameters = DateOfBirthValidatorParameters(minAge: 21, maxAge: 65)
        let validator = makeValidator(parameters: parameters)

        XCTAssertTrue(validator.isValid("15/07/1986"))
        XCTAssertFalse(validator.isValid("16/07/2005"))
        XCTAssertFalse(validator.isValid("14/07/1960"))
    }

    private func makeValidator(
        parameters: DateOfBirthValidatorParameters = .init()
    ) -> AdvancedDateOfBirthValidator {
        AdvancedDateOfBirthValidator(
            parameters: parameters,
            dateProvider: DateProviderStub(now: currentDate),
            calendar: gregorianCalendar
        )
    }

    private var gregorianCalendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        if let timeZone = TimeZone(secondsFromGMT: 0) {
            calendar.timeZone = timeZone
        }
        return calendar
    }
}
