# NameValidatorParameters

## Overview
`NameValidatorParameters` configures name validation rules, including minimum and maximum length, and whether only letters are allowed.

## Properties
- **minAmountOfCharacters** (`Int`): Minimum allowed characters. Default: `2`.
- **maxAmountOfCharacters** (`Int`): Maximum allowed characters. Default: `25`.
- **shouldHaveOnlyLetters** (`Bool`): Restrict to letters only. Default: `true`.

## Default Values
- `defaultMinCharacters`: 2
- `defaultMaxCharacters`: 25

## Initializer
```swift
init(minAmountOfCharacters: Int = Self.defaultMinCharacters,
     maxAmountOfCharacters: Int = Self.defaultMaxCharacters,
     shouldHaveOnlyLetters: Bool = true)
```

## Usage Example
```swift
let params = NameValidatorParameters(minAmountOfCharacters: 3, maxAmountOfCharacters: 20)
```
