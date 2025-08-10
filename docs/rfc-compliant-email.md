# RFCCompliantEmailValidator

Email validator that meets the RFC standard.

### Description

Use a complex regular expression to validate the emails structure.

### Usage

```swift
let validator = RFCCompliantEmailValidator()
validator.isValid("usuario@dominio.com") // true o false
```

---

### Methods

- `isValid(_ value: String) -> Bool`
