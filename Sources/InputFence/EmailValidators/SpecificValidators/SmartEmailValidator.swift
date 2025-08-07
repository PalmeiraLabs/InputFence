//
//  DataDetectorValidator.swift
//  InputFence
//
//  Created by Agustin Palmeira on 03/08/2025.
//

import Foundation

/// Email validator that uses `NSDataDetector` to detect if a string is a valid email address.
///
/// This validator leverages `NSDataDetector` with the `.link` checking type to find email links
/// within the input string and verifies if the entire string is a valid email address.
///
/// This approach can be more flexible and robust than simple regex-based validators, as it
/// uses Apple's data detection capabilities.
///
/// Example:
/// ```swift
/// let validator = SmartEmailValidator()
/// validator.isValid("user@example.com") // true
/// validator.isValid("invalid-email") // false
/// ```
public struct SmartEmailValidator: EmailValidatorProtocol {
    
    /// Creates a new instance of `SmartEmailValidator`.
    public init() {}
    
    /// Validates if the given string is a valid email address using `NSDataDetector`.
    ///
    /// - Parameter value: The email address string to validate.
    /// - Returns: `true` if the string is detected as an email link covering the entire string, `false` otherwise.
    public func isValid(_ value: String) -> Bool {
        guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else {
            return false
        }
        
        let range = NSRange(value.startIndex..., in: value)
        
        let matches: [NSTextCheckingResult] = detector.matches(in: value, options: [], range: range)
        return matches.contains { $0.url?.scheme == "mailto" && $0.range.length == value.count }
    }
}
