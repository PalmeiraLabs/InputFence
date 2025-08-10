# PasswordValidatorParameters

## Overview
`PasswordValidatorParameters` configures password validation rules, such as length, number of special characters, numbers, and allowed special characters.

## Properties
- **minAmountOfCharacters** (`Int`): Minimum allowed characters. Default: `5`.
- **maxAmountOfCharacters** (`Int`): Maximum allowed characters. Default: `30`.
- **minAmountOfSpecialCharacters** (`Int`): Minimum special characters. Default: `1`.
- **minAmountOfNumbers** (`Int`): Minimum numeric digits. Default: `1`.
- **specialCharacters** (`String`): Allowed special characters.

## Default Values
- `defaultMinCharacters`: 5
- `defaultMaxCharacters`: 30
- `defaultMinSpecialCharacters`: 1
- `defaultMinNumbers`: 1
- `defaultSpecialCharacters`: `!"#$%&'()*+,-./:;<=>?@[\]^_`{|}~`

## Initializer
```swift
init(minAmountOfCharacters: Int = Self.defaultMinCharacters,
     maxAmountOfCharacters: Int = Self.defaultMaxCharacters,
     minAmountOfSpecialCharacters: Int = Self.defaultMinSpecialCharacters,
     minAmountOfNumbers: Int = Self.defaultMinNumbers,
     specialCharacters: String = Self.defaultSpecialCharacters)
```

## Usage Example
```swift
let params = PasswordValidatorParameters(minAmountOfCharacters: 8, minAmountOfNumbers: 2)
```
