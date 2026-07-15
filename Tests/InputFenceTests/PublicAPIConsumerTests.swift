import XCTest
import InputFence

final class PublicAPIConsumerTests: XCTestCase {
    func test_publicAPI_whenImportedWithoutTestable_supportsCommonValidationFlow() {
        var emailValidator = EmailValidator(
            validator: SimpleEmailValidator(),
            value: "user@example.com"
        )

        XCTAssertTrue(emailValidator.isValid())

        emailValidator.config(validator: SimpleEmailValidator(), value: "invalid-email")

        XCTAssertFalse(emailValidator.isValid())
    }

    func test_publicAPI_whenPhoneParametersUseCorrectLabel_compilesAndValidates() {
        let parameters = PhoneValidatorParameters(isOnlyNumbersAllowed: true, region: "US")
        let validator = PhoneValidator(
            validator: AdvancedPhoneValidator(parameters: parameters),
            value: "6505551234"
        )

        XCTAssertTrue(validator.isValid())
    }
}
