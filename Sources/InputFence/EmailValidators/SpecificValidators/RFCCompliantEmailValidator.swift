//
//  RFCCompliantEmailValidator.swift
//  InputFence
//
//  Created by Agustin Palmeira on 02/08/2025.
//

/// A robust email validator using a regular expression based on RFC 5322.
/// https://datatracker.ietf.org/doc/html/rfc5322
///
/// This validator performs a strict check against the RFC 5322 specification,
/// which defines the syntax for valid email addresses. It's more comprehensive
/// than basic regex patterns, and covers edge cases such as quoted strings and IP literals.
///
/// - Warning: While based on the RFC, it may still reject some technically valid
/// but uncommon email formats, and is not guaranteed to match all RFC-compliant addresses.
///
/// - Note: The regex used is complex and attempts to cover most valid email formats defined by the RFC,
/// but may still reject some edge cases or accept some uncommon ones.
///
/// The validation is case-insensitive.
///
/// Example:
/// ```swift
/// let validator = RFCCompliantEmailValidator()
/// validator.isValid("user@example.com") // true
/// validator.isValid("invalid-email") // false
/// ```

import Foundation

public struct RFCCompliantEmailValidator: EmailValidatorProtocol {
    
    /// Creates a new instance of `RFCCompliantEmailValidator`.
    public init() {}
    
    /// Validates if the provided string is a valid email address according to RFC standards.
    ///
    /// - Parameter value: The email address string to validate.
    /// - Returns: `true` if the email address is valid, `false` otherwise.
    public func isValid(_ value: String) -> Bool {
        let emailRegEx = "(?:[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\\.)+[a-zA-Z]{2,}|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(?:\\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}|[a-zA-Z0-9-]*[a-zA-Z0-9]:.+)\\])"
        
        let emailPredicate = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx) // [c] case-insensitive
        return emailPredicate.evaluate(with: value)
    }
}

