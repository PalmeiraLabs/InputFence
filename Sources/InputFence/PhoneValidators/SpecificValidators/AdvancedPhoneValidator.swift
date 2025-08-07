//
//  AdvancedPhoneValidator.swift
//  InputFence
//
//  Created by Agustin Palmeira on 06/08/2025.
//

import PhoneNumberKit

/// Validator that checks if a phone number string is valid according to the provided parameters.
///
/// This validator uses the `PhoneNumberKit` library to parse and validate phone numbers
/// for a specified region and optionally enforces that the phone number contains only numeric characters.
///
/// Validation criteria:
/// - The string is not empty.
/// - If `parameters.isOnlyNumbersAllowed` is `true`, the string contains only numeric characters.
/// - The phone number can be successfully parsed by `PhoneNumberKit` for the given region.
///
/// Example:
/// ```swift
/// let validator = AdvancedPhoneValidator()
/// validator.isValid("+1 650-555-1234") // true
/// validator.isValid("123ABC") // false
/// ```
public struct AdvancedPhoneValidator: PhoneValidatorProtocol {
    
    /// Configuration parameters defining validation rules for the phone number.
    public var parameters: PhoneValidatorParameters

    private let phoneNumberKit = PhoneNumberKit()

    /// Initializes the validator with optional custom parameters.
    ///
    /// - Parameter parameters: Validation configuration. Defaults to `PhoneValidatorParameters()` with default region "US" and no numeric-only restriction.
    public init(parameters: PhoneValidatorParameters = .init()) {
        self.parameters = parameters
    }

    /// Validates if the given string is a valid phone number according to the parameters.
    ///
    /// - Parameter value: The phone number string to validate.
    /// - Returns: `true` if valid, `false` otherwise.
    public func isValid(_ value: String) -> Bool {
        guard !value.isEmpty else { return false }

        if parameters.isOnlyNumbersAllowed && !isOnlyNumbers(value) {
            return false
        }

        do {
            _ = try phoneNumberKit.parse(value,
                                         withRegion: parameters.region,
                                         ignoreType: true)
            return true
        } catch {
            return false
        }
    }

    /// Checks if the string contains only numeric characters.
    ///
    /// - Parameter value: Input string.
    /// - Returns: `true` if all characters are digits, `false` otherwise.
    private func isOnlyNumbers(_ value: String) -> Bool {
        return value.allSatisfy(\.isNumber)
    }
}
