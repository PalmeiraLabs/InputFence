import XCTest
@testable import InputFence

final class AdvancedPasswordValidatorTests: XCTestCase {
    func test_isValid_whenPasswordSatisfiesDefaultRules_returnsTrue() {
        let validator = AdvancedPasswordValidator()

        XCTAssertTrue(validator.isValid("abcde1!"))
        XCTAssertTrue(validator.isValid("P@ssw0rd123"))
    }

    func test_isValid_whenPasswordBreaksDefaultRules_returnsFalse() {
        let validator = AdvancedPasswordValidator()

        XCTAssertFalse(validator.isValid(""))
        XCTAssertFalse(validator.isValid("a1!"))
        XCTAssertFalse(validator.isValid(String(repeating: "a", count: 31) + "1!"))
        XCTAssertFalse(validator.isValid("abcdef!"))
        XCTAssertFalse(validator.isValid("abcdef1"))
    }

    func test_isValid_whenCustomRulesAreProvided_appliesCustomRules() {
        let parameters = PasswordValidatorParameters(
            minAmountOfCharacters: 4,
            maxAmountOfCharacters: 8,
            minAmountOfSpecialCharacters: 2,
            minAmountOfNumbers: 2,
            specialCharacters: "@#"
        )
        let validator = AdvancedPasswordValidator(parameters: parameters)

        XCTAssertTrue(validator.isValid("ab12@#"))
        XCTAssertFalse(validator.isValid("ab12!#"))
        XCTAssertFalse(validator.isValid("ab1@#"))
        XCTAssertFalse(validator.isValid("abcdef12@#"))
    }
}
