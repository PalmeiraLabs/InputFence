# PhoneValidatorParameters

## Overview
`PhoneValidatorParameters` defines rules for phone number validation, such as whether only numbers are allowed and the region code.

## Properties
- **isOnlyNumbersAllowed** (`Bool`): If `true`, only numeric characters are allowed. Default: `false`.
- **region** (`String`): Region code for validation. Default: `"US"`.

## Default Values
- `defaultIsOnlyNumbersAllowed`: false
- `defaultRegion`: "US"

## Initializer
```swift
init(isOnlyNumbersAllowd: Bool = Self.defaultIsOnlyNumbersAllowed,
     region: String = Self.defaultRegion)
```

## Usage Example
```swift
let params = PhoneValidatorParameters(isOnlyNumbersAllowd: true, region: "UK")
```
