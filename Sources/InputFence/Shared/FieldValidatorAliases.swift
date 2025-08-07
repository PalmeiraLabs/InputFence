//
//  FieldValidatorAliases.swift
//  InputFence
//
//  Created by Agustin Palmeira on 05/08/2025.
//

/// Typealias for a generic email field validator.
///
/// Wraps a validator conforming to `EmailValidatorProtocol` in a `FieldValidator`.
///
/// Example:
/// ```swift
/// let emailValidator = EmailValidator<RFCCompliantEmailValidator>(
///     validator: RFCCompliantEmailValidator(),
///     value: "user@example.com"
/// )
/// ```
public typealias EmailValidator<T: EmailValidatorProtocol> = FieldValidator<T>

/// Typealias for a generic password field validator.
///
/// Wraps a validator conforming to `PasswordValidatorProtocol` in a `FieldValidator`.
public typealias PasswordValidator<T: PasswordValidatorProtocol> = FieldValidator<T>

/// Typealias for a generic name field validator.
///
/// Wraps a validator conforming to `NameValidatorProtocol` in a `FieldValidator`.
public typealias NameValidator<T: NameValidatorProtocol> = FieldValidator<T>

/// Typealias for a generic username field validator.
///
/// Uses the same protocol as name validators (`NameValidatorProtocol`).
public typealias UsernameValidator<T: NameValidatorProtocol> = FieldValidator<T>

/// Typealias for a generic phone number field validator.
///
/// Wraps a validator conforming to `PhoneValidatorProtocol` in a `FieldValidator`.
public typealias PhoneValidator<T: PhoneValidatorProtocol> = FieldValidator<T>
