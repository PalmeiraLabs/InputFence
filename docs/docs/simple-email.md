# SimpleEmailValidator

Simple validator for emails that uses a simple regular expression.

### Description

Validates that the email has the basic format: local@domain.ext

### Usage

```swift
let validator = SimpleEmailValidator()
validator.isValid("usuario@domain.com") // true o false
```

---

### Methods

- `isValid(_ value: String) -> Bool`
