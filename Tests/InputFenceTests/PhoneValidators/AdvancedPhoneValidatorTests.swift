import XCTest
@testable import InputFence

final class AdvancedPhoneValidatorTests: XCTestCase {
    func test_isValid_whenValueIsEmpty_doesNotAskParserAndReturnsFalse() {
        let parser = PhoneNumberParserSpy()
        let validator = AdvancedPhoneValidator(parser: parser)

        XCTAssertFalse(validator.isValid(""))
        XCTAssertTrue(parser.parsedValues.isEmpty)
    }

    func test_isValid_whenOnlyNumbersRuleRejectsValue_doesNotAskParserAndReturnsFalse() {
        let parser = PhoneNumberParserSpy()
        let parameters = PhoneValidatorParameters(isOnlyNumbersAllowed: true)
        let validator = AdvancedPhoneValidator(parameters: parameters, parser: parser)

        XCTAssertFalse(validator.isValid("+1 650-555-1234"))
        XCTAssertTrue(parser.parsedValues.isEmpty)
    }

    func test_isValid_whenParserAcceptsValue_returnsTrue() {
        let parser = PhoneNumberParserSpy()
        parser.canParseResult = true
        let validator = AdvancedPhoneValidator(parser: parser)

        XCTAssertTrue(validator.isValid("6505551234"))
        XCTAssertEqual(parser.parsedValues.count, 1)
        XCTAssertEqual(parser.parsedValues.first?.value, "6505551234")
        XCTAssertEqual(parser.parsedValues.first?.region, "US")
    }

    func test_isValid_whenParserRejectsValue_returnsFalse() {
        let parser = PhoneNumberParserSpy()
        parser.canParseResult = false
        let validator = AdvancedPhoneValidator(parser: parser)

        XCTAssertFalse(validator.isValid("123"))
        XCTAssertEqual(parser.parsedValues.count, 1)
    }
}
