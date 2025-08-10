# AdvancedDateOfBirthValidator

Validator for birth dates in the "dd/MM/yyyy" format.

### Description

Validates that:
- The string is not empty.
- It has exactly 10 characters (expected format).
- The date is valid and not in the future.
- The calculated age is within the allowed range (default is 18 to 120 years).

### Usage

```swift
let validator = AdvancedDateOfBirthValidator()
validator.isValid("01/01/2000") // true o false
```

### Configuration

Can be configured via DateOfBirthValidatorParameters to change the minimum and maximum age.

---

### Properties

- `parameters`: Validation configuration parameters.

---

### Métodos

- `isValid(_ value: String) -> Bool` - Validates the date.
