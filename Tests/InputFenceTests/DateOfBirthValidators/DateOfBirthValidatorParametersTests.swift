import XCTest
@testable import InputFence

final class DateOfBirthValidatorParametersTests: XCTestCase {
    func test_init_whenNoArgumentsProvided_usesDocumentedDefaults() {
        let parameters = DateOfBirthValidatorParameters()

        XCTAssertEqual(parameters.minAge, 18)
        XCTAssertEqual(parameters.maxAge, 120)
    }

    func test_init_whenArgumentsProvided_storesOverrides() {
        let parameters = DateOfBirthValidatorParameters(minAge: 21, maxAge: 65)

        XCTAssertEqual(parameters.minAge, 21)
        XCTAssertEqual(parameters.maxAge, 65)
    }
}
