# AdvancedNameValidator

Advanced validator for names, surnames, usernames.

### Descripción

Validates the following:
- Name value not empty.
- The amount of characters inside the permitted range (default 2 to 25).
- Optional, only letters permitted.

### Uso

```swift
let validator = AdvancedNameValidator()
validator.isValid("Agustín") // true o false
```

### Configuration

Can be configured with `NameValidatorParameters`.

---

### Properties

- `parameters`: Validation parameters.

---

### Methods

- `isValid(_ value: String) -> Bool`
