import XCTest
@testable import InputFence

final class FieldValidatorAliasesTests: XCTestCase {
    func test_isValid_whenAliasesWrapValidValues_returnTrue() {
        let emailValidator = EmailValidator(validator: SimpleEmailValidator(), value: "user@example.com")
        let passwordValidator = PasswordValidator(validator: AdvancedPasswordValidator(), value: "abcde1!")
        let nameValidator = NameValidator(validator: AdvancedNameValidator(), value: "Ana")
        let usernameValidator = UsernameValidator(validator: AdvancedNameValidator(), value: "Agustin")
        let phoneValidator = PhoneValidator(validator: AdvancedPhoneValidator(), value: "6505551234")

        XCTAssertTrue(emailValidator.isValid())
        XCTAssertTrue(passwordValidator.isValid())
        XCTAssertTrue(nameValidator.isValid())
        XCTAssertTrue(usernameValidator.isValid())
        XCTAssertTrue(phoneValidator.isValid())
    }
}
