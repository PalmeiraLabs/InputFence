//
//  NameValidatorParameters.swift
//  InputFence
//
//  Created by Agustin Palmeira on 05/08/2025.
//

/// Parameters to configure the behavior of a `NameValidator`.
///
/// Allows setting constraints such as minimum and maximum length,
/// and whether the name should contain only letters.
///
/// Use this struct to customize the validation rules for names.
public struct NameValidatorParameters {
    
    /// The minimum number of characters allowed in the name.
    ///
    /// Defaults to `2`.
    public var minAmountOfCharacters: Int
    
    /// The maximum number of characters allowed in the name.
    ///
    /// Defaults to `25`.
    public var maxAmountOfCharacters: Int
    
    /// Indicates whether the name should contain only letters (no numbers, symbols, or whitespace).
    ///
    /// Defaults to `true`.
    public var shouldHaveOnlyLetters: Bool
    
    
    /// Creates a new instance of `NameValidatorParameters`.
    ///
    /// - Parameters:
    ///   - minAmountOfCharacters: Minimum allowed characters in the name. Defaults to `NameValidatorParameters.defaultMinCharacters`.
    ///   - maxAmountOfCharacters: Maximum allowed characters in the name. Defaults to `NameValidatorParameters.defaultMaxCharacters`.
    ///   - shouldHaveOnlyLetters: Whether the name should only contain letters. Defaults to `true`.
    public init(minAmountOfCharacters: Int = Self.defaultMinCharacters,
                maxAmountOfCharacters: Int = Self.defaultMaxCharacters,
                shouldHaveOnlyLetters: Bool = true) {
        self.minAmountOfCharacters = minAmountOfCharacters
        self.maxAmountOfCharacters = maxAmountOfCharacters
        self.shouldHaveOnlyLetters = shouldHaveOnlyLetters
    }
}

public extension NameValidatorParameters {
    /// Default minimum characters allowed for a valid name.
    static let defaultMinCharacters: Int = 2
    
    /// Default maximum characters allowed for a valid name.
    static let defaultMaxCharacters: Int = 25
}
