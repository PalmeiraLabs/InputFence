//
//  PasswordValidatorParameters.swift
//  InputFence
//
//  Created by Agustin Palmeira on 06/08/2025.
//


/// Parameters to configure the behavior of a `PhoneValidator`.
///
/// Defines if the phone number should contain only numeric characters,
/// and the region code used for validation.
///
/// Use this struct to customize phone number validation rules.
public struct PhoneValidatorParameters {
    
    /// Indicates whether the phone number should contain only numeric characters.
    ///
    /// Defaults to `false`.
    public var isOnlyNumbersAllowed: Bool
    
    /// The region code (e.g., "US") used to validate the phone number format.
    ///
    /// Defaults to `"US"`.
    public var region: String

    /// Creates a new instance of `PhoneValidatorParameters`.
    ///
    /// - Parameters:
    ///   - isOnlyNumbersAllowed: If true, only numeric characters are allowed in the phone number. Defaults to `false`.
    ///   - region: The region code used for validation. Defaults to `"US"`.
    public init(
        isOnlyNumbersAllowd: Bool = Self.defaultIsOnlyNumbersAllowed,
        region: String = Self.defaultRegion
    ) {
        self.isOnlyNumbersAllowed = isOnlyNumbersAllowd
        self.region = region
    }
}

public extension PhoneValidatorParameters {
    /// Default value indicating if only numeric characters are allowed.
    static let defaultIsOnlyNumbersAllowed: Bool = false
    
    /// Default region code for phone validation.
    static let defaultRegion: String = "US"
}
