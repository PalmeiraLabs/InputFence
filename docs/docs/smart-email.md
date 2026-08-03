# SmartEmailValidator

Validator that uses NSDataDetector to validate emails.

### Description

Uses apple data detector to identify if the complete string is a valid email.

### Usage

```swift
let validator = SmartEmailValidator()
validator.isValid("usuario@dominio.com") // true o false
```

---

### Methods

- `isValid(_ value: String) -> Bool`
