//
//  ValidatorProtocol.swift
//  InputFence
//
//  Created by Agustin Palmeira on 05/08/2025.
//


/// Base protocol that defines a generic validator.
///
/// Any validator conforming to this protocol must implement
/// the `isValid(_:)` method to check if a string value is valid.
public protocol ValidatorProtocol {
    
    /// Validates the given string value.
    ///
    /// - Parameter value: The string to validate.
    /// - Returns: `true` if the value is valid, `false` otherwise.
    func isValid(_ value: String) -> Bool
}

/// Protocol for email validators.
///
/// Inherits from `ValidatorProtocol`.
/// Use this protocol to define validators that specifically
/// validate email addresses.
public protocol EmailValidatorProtocol: ValidatorProtocol {}

/// Protocol for password validators.
///
/// Inherits from `ValidatorProtocol`.
/// Use this protocol to define validators that specifically
/// validate passwords.
public protocol PasswordValidatorProtocol: ValidatorProtocol {}

/// Protocol for name validators.
///
/// Inherits from `ValidatorProtocol`.
/// Use this protocol to define validators that specifically
/// validate names.
public protocol NameValidatorProtocol: ValidatorProtocol {}

/// Protocol for date of birth validators.
///
/// Inherits from `ValidatorProtocol`.
/// Use this protocol to define validators that specifically
/// validate date of birth strings.
public protocol DateOfBirthValidatorProtocol: ValidatorProtocol {}

/// Protocol for phone number validators.
///
/// Inherits from `ValidatorProtocol`.
/// Use this protocol to define validators that specifically
/// validate phone numbers.
public protocol PhoneValidatorProtocol: ValidatorProtocol {}
