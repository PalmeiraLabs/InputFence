import XCTest
@testable import InputFence

final class SmartEmailValidatorTests: XCTestCase {
    func test_isValid_whenInputIsOnlyAnEmail_returnsTrue() {
        let validator = SmartEmailValidator()

        XCTAssertTrue(validator.isValid("user@example.com"))
        XCTAssertTrue(validator.isValid("first.last+tag@example.co"))
    }

    func test_isValid_whenInputIsNotOnlyAnEmail_returnsFalse() {
        let validator = SmartEmailValidator()

        XCTAssertFalse(validator.isValid(""))
        XCTAssertFalse(validator.isValid("invalid-email"))
        XCTAssertFalse(validator.isValid("Contact me at user@example.com"))
        XCTAssertFalse(validator.isValid("https://example.com"))
    }
}
