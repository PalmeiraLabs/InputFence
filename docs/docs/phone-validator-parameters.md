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
init()

init(isOnlyNumbersAllowed: Bool,
     region: String = Self.defaultRegion)
```

Use `init()` for the documented defaults. The legacy initializer label `isOnlyNumbersAllowd` remains available for source compatibility.

## Usage Example
```swift
let defaultParams = PhoneValidatorParameters()
let params = PhoneValidatorParameters(isOnlyNumbersAllowed: true, region: "UK")
```
