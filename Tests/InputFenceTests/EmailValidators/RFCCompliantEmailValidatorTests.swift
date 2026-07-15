import XCTest
@testable import InputFence

final class RFCCompliantEmailValidatorTests: XCTestCase {
    func test_isValid_whenEmailUsesCommonOrQuotedLocalPart_returnsTrue() {
        let validator = RFCCompliantEmailValidator()

        XCTAssertTrue(validator.isValid("user@example.com"))
        XCTAssertTrue(validator.isValid("first.last+tag@example.co.uk"))
        XCTAssertTrue(validator.isValid("\"quoted.local\"@example.com"))
    }

    func test_isValid_whenEmailViolatesFormat_returnsFalse() {
        let validator = RFCCompliantEmailValidator()

        XCTAssertFalse(validator.isValid(""))
        XCTAssertFalse(validator.isValid("invalid-email"))
        XCTAssertFalse(validator.isValid("user@example"))
        XCTAssertFalse(validator.isValid("user..name@example.com"))
        XCTAssertFalse(validator.isValid("user@example..com"))
    }
}
