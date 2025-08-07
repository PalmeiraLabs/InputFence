//
//  Untitled.swift
//  InputFence
//
//  Created by Agustin Palmeira on 03/08/2025.
//

import Foundation

/// Simple email validator that checks if an email address matches a basic pattern.
///
/// This validator uses a straightforward regular expression to verify the general structure
/// of an email address: a local part, an '@' symbol, a domain, and a valid top-level domain.
///
/// It is less comprehensive than `RFCCompliantEmailValidator` and may accept some invalid emails
/// or reject some valid but uncommon formats.
///
/// Example:
/// ```swift
/// let validator = SimpleEmailValidator()
/// validator.isValid("user@example.com") // true
/// validator.isValid("invalid-email") // false
/// ```
public struct SimpleEmailValidator: EmailValidatorProtocol {
    
    /// Creates a new instance of `SimpleEmailValidator`.
    public init() {}
    
    /// Validates if the given string is a valid email address using a simple regex.
    ///
    /// - Parameter value: The email address string to validate.
    /// - Returns: `true` if the string matches the email pattern, `false` otherwise.
    public func isValid(_ value: String) -> Bool {
        let regex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: value)
    }
}
