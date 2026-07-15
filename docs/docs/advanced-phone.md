# AdvancedPhoneValidator

Advanced validator for phone numbers.

### Description

Uses the library `PhoneNumberKit` to validate phone numbers.

Allows to configure:

- If only numbers are allowed.
- Region for the phone format (by default "US").

### Usage

```swift
let validator = AdvancedPhoneValidator()
validator.isValid("+1 650-555-1234") // true o false
```

### Configuration

Can be configured with `PhoneValidatorParameters`.

---

### Properties

- `parameters`: Validation parameters.

---

### Methods

- `isValid(_ value: String) -> Bool`
