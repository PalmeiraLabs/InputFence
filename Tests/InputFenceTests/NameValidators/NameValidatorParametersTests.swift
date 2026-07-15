import XCTest
@testable import InputFence

final class NameValidatorParametersTests: XCTestCase {
    func test_init_whenNoArgumentsProvided_usesDocumentedDefaults() {
        let parameters = NameValidatorParameters()

        XCTAssertEqual(parameters.minAmountOfCharacters, 2)
        XCTAssertEqual(parameters.maxAmountOfCharacters, 25)
        XCTAssertTrue(parameters.shouldHaveOnlyLetters)
    }

    func test_init_whenArgumentsProvided_storesOverrides() {
        let parameters = NameValidatorParameters(
            minAmountOfCharacters: 3,
            maxAmountOfCharacters: 10,
            shouldHaveOnlyLetters: false
        )

        XCTAssertEqual(parameters.minAmountOfCharacters, 3)
        XCTAssertEqual(parameters.maxAmountOfCharacters, 10)
        XCTAssertFalse(parameters.shouldHaveOnlyLetters)
    }
}
