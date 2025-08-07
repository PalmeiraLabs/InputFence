//
//  PasswordValidator.swift
//  InputFence
//
//  Created by Agustin Palmeira on 02/08/2025.
//

/// Validator that checks if a password string is valid according to the provided parameters.
///
/// This validator verifies:
/// - The string is not empty.
/// - The length of the string is within the allowed range defined by `parameters`.
/// - The string contains at least the minimum number of numeric digits.
/// - The string contains at least the minimum number of special characters as defined in `parameters`.
///
/// Example:
/// ```swift
/// let validator = AdvancedPasswordValidator()
/// validator.isValid("P@ssw0rd123") // true
/// validator.isValid("pass") // false, too short and missing special chars/numbers
/// ```
public struct AdvancedPasswordValidator: PasswordValidatorProtocol {
    
    /// Configuration parameters defining validation rules for the password.
    public var parameters: PasswordValidatorParameters
    
    /// Initializes the validator with optional custom parameters.
    ///
    /// - Parameter parameters: Validation configuration. Defaults to `PasswordValidatorParameters()` with sensible defaults.
    public init(parameters: PasswordValidatorParameters = .init()) {
        self.parameters = parameters
    }
    
    /// Validates if the given string is a valid password according to the parameters.
    ///
    /// - Parameter value: The password string to validate.
    /// - Returns: `true` if valid, `false` otherwise.
    public func isValid(_ value: String) -> Bool {
        guard !value.isEmpty,
              isAmountOfCharactersValid(value),
              isAmountOfNumbersValid(value),
              isAmountOfSpecialCharactersValid(value) else {
            return false
        }
        
        return true
    }
    
    /// Checks if the string length is within the configured min and max limits.
    ///
    /// - Parameter value: Input string.
    /// - Returns: `true` if length is valid, `false` otherwise.
    private func isAmountOfCharactersValid(_ value: String) -> Bool {
        return (value.count >= self.parameters.minAmountOfCharacters) && (value.count <= self.parameters.maxAmountOfCharacters)
    }
    
    /// Checks if the string contains at least the minimum required numeric digits.
    ///
    /// - Parameter value: Input string.
    /// - Returns: `true` if numeric digit count is valid, `false` otherwise.
    private func isAmountOfNumbersValid(_ value: String) -> Bool {
        return value.filter { $0.isNumber }.count >= self.parameters.minAmountOfNumbers
    }
    
    /// Checks if the string contains at least the minimum required special characters.
    ///
    /// - Parameter value: Input string.
    /// - Returns: `true` if special character count is valid, `false` otherwise.
    private func isAmountOfSpecialCharactersValid(_ value: String) -> Bool {
        return value.filter {
            self.parameters.specialCharacters.contains($0)
        }.count >= self.parameters.minAmountOfSpecialCharacters
    }
}
