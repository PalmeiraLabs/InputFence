import XCTest
@testable import InputFence

final class SimpleEmailValidatorTests: XCTestCase {
    func test_isValid_whenEmailHasBasicStructure_returnsTrue() {
        let validator = SimpleEmailValidator()

        XCTAssertTrue(validator.isValid("user@example.com"))
        XCTAssertTrue(validator.isValid("first.last+tag@sub.example.co"))
    }

    func test_isValid_whenEmailIsInvalid_returnsFalse() {
        let validator = SimpleEmailValidator()

        XCTAssertFalse(validator.isValid(""))
        XCTAssertFalse(validator.isValid("invalid-email"))
        XCTAssertFalse(validator.isValid("user@example"))
        XCTAssertFalse(validator.isValid("@example.com"))
        XCTAssertFalse(validator.isValid("user name@example.com"))
    }
}
