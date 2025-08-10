# DateOfBirthValidatorParameters

## Overview
`DateOfBirthValidatorParameters` defines the configuration for validating a date of birth.  
It allows specifying the minimum and maximum allowed ages.

## Properties
- **minAge** (`Int`): The minimum allowed age (inclusive). Default: `18`.
- **maxAge** (`Int`): The maximum allowed age (inclusive). Default: `120`.

## Default Values
- `defaultMinAge`: 18
- `defaultMaxAge`: 120

## Initializer
```swift
init(minAge: Int = Self.defaultMinAge, maxAge: Int = Self.defaultMaxAge)
```
Creates a new instance with optional custom min and max ages.

## Usage Example
```swift
let params = DateOfBirthValidatorParameters(minAge: 21, maxAge: 65)
```
