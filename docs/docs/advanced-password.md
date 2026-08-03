# AdvancedPasswordValidator

Advanced validator for passwords.

### Description

Validates that the password follows the following items:

- Minimum and maximum length (by default 5 to 30 characters).
- Minimum amount of numbers.
- Minimum amount of special characters defined.

### Usage

```swift
let validator = AdvancedPasswordValidator()
validator.isValid("P@ssw0rd123") // true o false
```

### Configuration

Can be configured with `PasswordValidatorParameters`.

---

### Properties

- `parameters`: Validation parameters.

---

### Methods

- `isValid(_ value: String) -> Bool`
