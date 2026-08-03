import XCTest
@testable import InputFence

final class AdvancedNameValidatorTests: XCTestCase {
    func test_isValid_whenNameSatisfiesDefaultRules_returnsTrue() {
        let validator = AdvancedNameValidator()

        XCTAssertTrue(validator.isValid("Agustin"))
        XCTAssertTrue(validator.isValid("Ana"))
    }

    func test_isValid_whenNameBreaksDefaultRules_returnsFalse() {
        let validator = AdvancedNameValidator()

        XCTAssertFalse(validator.isValid(""))
        XCTAssertFalse(validator.isValid("A"))
        XCTAssertFalse(validator.isValid(String(repeating: "a", count: 26)))
        XCTAssertFalse(validator.isValid("Ana Maria"))
        XCTAssertFalse(validator.isValid("Ana1"))
    }

    func test_isValid_whenOnlyLettersRuleIsDisabled_allowsNonLetterCharacters() {
        let parameters = NameValidatorParameters(shouldHaveOnlyLetters: false)
        let validator = AdvancedNameValidator(parameters: parameters)

        XCTAssertTrue(validator.isValid("Ana Maria"))
        XCTAssertTrue(validator.isValid("Ana1"))
    }
}
