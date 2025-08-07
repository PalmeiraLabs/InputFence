//
//  DateOfBirthValidatorParameters.swift
//  InputFence
//
//  Created by Agustin Palmeira on 06/08/2025.
//

/// Parameters to configure the behavior of a `DateOfBirthValidator`.
///
/// Allows setting minimum and maximum allowed ages for validation.
///
/// Use this struct to define age constraints when validating a date of birth.
public struct DateOfBirthValidatorParameters {
    
    /// The minimum allowed age (inclusive) for a valid date of birth.
    ///
    /// Defaults to `18`.
    public var minAge: Int
    
    /// The maximum allowed age (inclusive) for a valid date of birth.
    ///
    /// Defaults to `120`.
    public var maxAge: Int
    
    /// Creates a new instance of `DateOfBirthValidatorParameters`.
    ///
    /// - Parameters:
    ///   - minAge: The minimum allowed age. Defaults to `DateOfBirthValidatorParameters.defaultMinAge` (18).
    ///   - maxAge: The maximum allowed age. Defaults to `DateOfBirthValidatorParameters.defaultMaxAge` (120).
    public init(minAge: Int = Self.defaultMinAge,
                maxAge: Int = Self.defaultMaxAge) {
        self.minAge = minAge
        self.maxAge = maxAge
    }
}

public extension DateOfBirthValidatorParameters {
    /// The default minimum allowed age for validation.
    static let defaultMinAge: Int = 18
    
    /// The default maximum allowed age for validation.
    static let defaultMaxAge: Int = 120
}
