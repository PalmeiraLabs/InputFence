import XCTest
@testable import InputFence

final class PhoneValidatorParametersTests: XCTestCase {
    func test_init_whenNoArgumentsProvided_usesDocumentedDefaults() {
        let parameters = PhoneValidatorParameters()

        XCTAssertFalse(parameters.isOnlyNumbersAllowed)
        XCTAssertEqual(parameters.region, "US")
    }

    @available(*, deprecated, message: "Exercises the deprecated compatibility initializer.")
    func test_init_whenLegacyArgumentLabelIsUsed_storesOverrides() {
        let parameters = PhoneValidatorParameters(isOnlyNumbersAllowd: true, region: "AR")

        XCTAssertTrue(parameters.isOnlyNumbersAllowed)
        XCTAssertEqual(parameters.region, "AR")
    }

    func test_init_whenCorrectArgumentLabelIsUsed_storesOverrides() {
        let parameters = PhoneValidatorParameters(isOnlyNumbersAllowed: true, region: "AR")

        XCTAssertTrue(parameters.isOnlyNumbersAllowed)
        XCTAssertEqual(parameters.region, "AR")
    }
}
