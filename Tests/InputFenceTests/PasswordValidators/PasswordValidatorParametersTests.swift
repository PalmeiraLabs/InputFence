import XCTest
@testable import InputFence

final class PasswordValidatorParametersTests: XCTestCase {
    func test_init_whenNoArgumentsProvided_usesDocumentedDefaults() {
        let parameters = PasswordValidatorParameters()

        XCTAssertEqual(parameters.minAmountOfCharacters, 5)
        XCTAssertEqual(parameters.maxAmountOfCharacters, 30)
        XCTAssertEqual(parameters.minAmountOfSpecialCharacters, 1)
        XCTAssertEqual(parameters.minAmountOfNumbers, 1)
        XCTAssertEqual(parameters.specialCharacters, "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~")
    }

    func test_init_whenArgumentsProvided_storesOverrides() {
        let parameters = PasswordValidatorParameters(
            minAmountOfCharacters: 8,
            maxAmountOfCharacters: 12,
            minAmountOfSpecialCharacters: 2,
            minAmountOfNumbers: 3,
            specialCharacters: "@#"
        )

        XCTAssertEqual(parameters.minAmountOfCharacters, 8)
        XCTAssertEqual(parameters.maxAmountOfCharacters, 12)
        XCTAssertEqual(parameters.minAmountOfSpecialCharacters, 2)
        XCTAssertEqual(parameters.minAmountOfNumbers, 3)
        XCTAssertEqual(parameters.specialCharacters, "@#")
    }
}
