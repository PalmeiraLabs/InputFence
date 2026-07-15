import XCTest
@testable import InputFence

final class FieldValidatorTests: XCTestCase {
    func test_isValid_whenConfiguredValidatorAcceptsValue_returnsTrue() {
        let validator = FieldValidator(validator: ValidatorStub(), value: "anything")

        XCTAssertTrue(validator.isValid())
    }

    func test_isValid_whenConfiguredValidatorRejectsValue_returnsFalse() {
        let validator = FieldValidator(
            validator: ValidatorStub(acceptedValue: "expected"),
            value: "unexpected"
        )

        XCTAssertFalse(validator.isValid())
    }

    func test_config_whenValidatorAndValueChange_usesLatestConfiguration() {
        var validator = FieldValidator(validator: ValidatorStub(), value: "anything")

        XCTAssertTrue(validator.isValid())

        validator.config(validator: ValidatorStub(acceptedValue: "expected"), value: "unexpected")

        XCTAssertFalse(validator.isValid())
    }
}
