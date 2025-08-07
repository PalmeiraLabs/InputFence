//
//  AdvancedPasswordValidator.swift
//  InputFence
//
//  Created by Agustin Palmeira on 06/08/2025.
//

/// Validator that checks if a name string is valid according to the provided parameters.
///
/// This validator verifies:
/// - The string is not empty.
/// - The length of the string is within the allowed range defined by `parameters`.
/// - If required, the string contains only letters.
///
/// Use `parameters.shouldHaveOnlyLetters` to specify if the name should contain exclusively letters.
///
/// Example:
/// ```swift
/// let validator = AdvancedNameValidator()
/// validator.isValid("Agustin") // true
/// validator.isValid("A1") // false if shouldHaveOnlyLetters is true
/// ```
public struct AdvancedNameValidator: NameValidatorProtocol {
    
    /// Configuration parameters defining validation rules for the name.
    public var parameters: NameValidatorParameters
    
    /// Initializes the validator with optional custom parameters.
    ///
    /// - Parameter parameters: Validation configuration. Defaults to `NameValidatorParameters()` with min 2 chars, max 25 chars, and only letters.
    public init(parameters: NameValidatorParameters = .init()) {
        self.parameters = parameters
    }
    
    /// Validates if the given string is a valid name according to the parameters.
    ///
    /// - Parameter value: The name string to validate.
    /// - Returns: `true` if valid, `false` otherwise.
    public func isValid(_ value: String) -> Bool {
        guard !value.isEmpty,
              isAmountOfCharactersValid(value),
              isLetterValid(value) else {
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
    
    /// Checks if the string contains only letters if required by parameters.
    ///
    /// - Parameter value: Input string.
    /// - Returns: `true` if only letters or if letter-only restriction is disabled.
    private func isLetterValid(_ value: String) -> Bool {
        guard parameters.shouldHaveOnlyLetters else { return true }
        return value.allSatisfy { $0.isLetter }
    }
}
