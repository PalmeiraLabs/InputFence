//
//  AdvancedNameValidator.swift
//  InputFence
//
//  Created by Agustin Palmeira on 06/08/2025.
//

import Foundation

/// Validator that checks if a date of birth string is valid according to specified age constraints.
///
/// The date string must follow the format `"dd/MM/yyyy"` and the age calculated must be within the allowed
/// range defined by `parameters`.
///
/// This validator ensures:
/// - The input string is not empty.
/// - The input string has exactly 10 characters (matching `"dd/MM/yyyy"` format).
/// - The date is valid and not in the future.
/// - The age calculated from the date is between `parameters.minAge` and `parameters.maxAge`.
public struct AdvancedDateOfBirthValidator: DateOfBirthValidatorProtocol {
    
    /// Configuration parameters that define minimum and maximum allowed ages for validation.
    public var parameters: DateOfBirthValidatorParameters
    
    /// Initializes the validator with custom parameters.
    ///
    /// - Parameter parameters: Configuration defining valid age range. Defaults to `DateOfBirthValidatorParameters()` with minAge 18 and maxAge 120.
    public init(parameters: DateOfBirthValidatorParameters = .init()) {
        self.parameters = parameters
    }
    
    /// Validates if the given date of birth string is valid.
    ///
    /// - Parameter value: Date of birth string in the format `"dd/MM/yyyy"`.
    /// - Returns: `true` if valid, `false` otherwise.
    public func isValid(_ value: String) -> Bool {
        guard !value.isEmpty,
              isAmountOfCharactersValid(value),
              isDateValid(value) else {
            return false
        }
        
        return true
    }
    
    /// Checks if the input string has exactly 10 characters (expected for `"dd/MM/yyyy"` format).
    ///
    /// - Parameter value: Input string.
    /// - Returns: `true` if length is exactly 10, `false` otherwise.
    private func isAmountOfCharactersValid(_ value: String) -> Bool {
        return (value.count == 10)
    }
    
    /// Validates if the input string can be converted to a valid date, is not in the future,
    /// and that the age falls within allowed range.
    ///
    /// - Parameter value: Date of birth string.
    /// - Returns: `true` if valid date and age, `false` otherwise.
    private func isDateValid(_ value: String) -> Bool {
        guard let dateOfBirth = dateOfBirth(from: value) else { return false }
        
        if isInFuture(dateOfBirth) { return false }
        
        return validateAge(dateOfBirth: dateOfBirth)
    }
    
    /// Validates that the age computed from the date of birth is within allowed min and max age.
    ///
    /// - Parameter dateOfBirth: Date of birth.
    /// - Returns: `true` if age is within `parameters.minAge` and `parameters.maxAge`.
    ///
    /// - Note: This method relies on the system calendar and date settings, which can be modified by the user.
    private func validateAge(dateOfBirth: Date) -> Bool {
        let now = Date()
        
        guard let age = Calendar.current.dateComponents([.year], from: dateOfBirth, to: now).year else {
             return false
         }

        if age < self.parameters.minAge {
             return false
         }

        if age > self.parameters.maxAge {
             return false
         }
        
        return true
    }
    
    /// Checks if the given date is in the future compared to the current date.
    ///
    /// - Parameter date: Date to check.
    /// - Returns: `true` if date is in the future, `false` otherwise.
    ///
    /// - Note: This method relies on the system date settings, which can be modified by the user.
    private func isInFuture(_ date: Date) -> Bool {
        return date > Date()
    }
    
    /// Parses a date of birth string into a `Date` object.
    ///
    /// - Parameter string: Date string in `"dd/MM/yyyy"` format.
    /// - Returns: A `Date` if parsing succeeds, or `nil` if it fails.
    private func dateOfBirth(from string: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX") // Ensures consistent parsing
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter.date(from: string)
    }
}
