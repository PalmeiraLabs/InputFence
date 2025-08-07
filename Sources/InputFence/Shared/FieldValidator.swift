//
//  FieldValidator.swift
//  InputFence
//
//  Created by Agustin Palmeira on 05/08/2025.
//

/// A generic field validator that uses a specified validator conforming to `ValidatorProtocol`
/// to validate a string value.
///
/// This struct allows associating a validator with a value and performing validation.
///
/// - Note: The struct is generic over any type `T` that conforms to `ValidatorProtocol`.
///
/// Example:
/// ```swift
/// var emailValidator = FieldValidator(validator: RFCCompliantEmailValidator(), value: "test@example.com")
/// print(emailValidator.isValid()) // true or false depending on validity
/// ```
public struct FieldValidator<T: ValidatorProtocol> {
    
    private var validator: T
    private var value: String

    /// Initializes a new `FieldValidator` with the given validator and value.
    ///
    /// - Parameters:
    ///   - validator: The validator to use.
    ///   - value: The string value to validate.
    public init(validator: T, value: String) {
        self.validator = validator
        self.value = value
    }

    /// Configures the validator and value.
    ///
    /// - Parameters:
    ///   - validator: The new validator to use.
    ///   - value: The new string value to validate.
    public mutating func config(validator: T, value: String) {
        self.validator = validator
        self.value = value
    }

    /// Validates the current value using the configured validator.
    ///
    /// - Returns: `true` if the value is valid, `false` otherwise.
    public func isValid() -> Bool {
        return validator.isValid(self.value)
    }
}
