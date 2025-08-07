//
//  PasswordValidatorParameters.swift
//  InputFence
//
//  Created by Agustin Palmeira on 04/08/2025.
//

/// Parameters to configure the behavior of a `PasswordValidator`.
///
/// Defines constraints such as minimum and maximum length, minimum count of special characters,
/// minimum count of numeric digits, and which characters are considered special.
///
/// Use this struct to customize password validation rules.
public struct PasswordValidatorParameters {
    
    /// The minimum number of characters allowed in the password.
    ///
    /// Defaults to `5`.
    public var minAmountOfCharacters: Int
    
    /// The maximum number of characters allowed in the password.
    ///
    /// Defaults to `30`.
    public var maxAmountOfCharacters: Int
    
    /// The minimum number of special characters required in the password.
    ///
    /// Defaults to `1`.
    public var minAmountOfSpecialCharacters: Int
    
    /// The minimum number of numeric digits required in the password.
    ///
    /// Defaults to `1`.
    public var minAmountOfNumbers: Int
    
    /// The string containing all characters considered as special characters.
    ///
    /// Defaults to `!"#$%&'()*+,-./:;<=>?@[\]^_`{|}~`.
    public var specialCharacters: String

    /// Creates a new instance of `PasswordValidatorParameters`.
    ///
    /// - Parameters:
    ///   - minAmountOfCharacters: Minimum allowed characters in the password. Defaults to `PasswordValidatorParameters.defaultMinCharacters`.
    ///   - maxAmountOfCharacters: Maximum allowed characters in the password. Defaults to `PasswordValidatorParameters.defaultMaxCharacters`.
    ///   - minAmountOfSpecialCharacters: Minimum required special characters. Defaults to `PasswordValidatorParameters.defaultMinSpecialCharacters`.
    ///   - minAmountOfNumbers: Minimum required numeric digits. Defaults to `PasswordValidatorParameters.defaultMinNumbers`.
    ///   - specialCharacters: Characters considered special. Defaults to `PasswordValidatorParameters.defaultSpecialCharacters`.
    public init(
        minAmountOfCharacters: Int = Self.defaultMinCharacters,
        maxAmountOfCharacters: Int = Self.defaultMaxCharacters,
        minAmountOfSpecialCharacters: Int = Self.defaultMinSpecialCharacters,
        minAmountOfNumbers: Int = Self.defaultMinNumbers,
        specialCharacters: String = Self.defaultSpecialCharacters
    ) {
        self.minAmountOfCharacters = minAmountOfCharacters
        self.maxAmountOfCharacters = maxAmountOfCharacters
        self.minAmountOfSpecialCharacters = minAmountOfSpecialCharacters
        self.minAmountOfNumbers = minAmountOfNumbers
        self.specialCharacters = specialCharacters
    }
}

public extension PasswordValidatorParameters {
    /// Default minimum characters allowed for a valid password.
    static let defaultMinCharacters: Int = 5
    
    /// Default maximum characters allowed for a valid password.
    static let defaultMaxCharacters: Int = 30
    
    /// Default minimum special characters required in the password.
    static let defaultMinSpecialCharacters: Int = 1
    
    /// Default minimum numeric digits required in the password.
    static let defaultMinNumbers: Int = 1
    
    /// Default characters considered special for password validation.
    static let defaultSpecialCharacters: String = "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"
}
