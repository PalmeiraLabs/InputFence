# Validation Protocolos

Protocols definition for validators.

## ValidatorProtocol

Base protocol that defines the method:

```swift
func isValid(_ value: String) -> Bool
```

## Specific protocols específicos

They inherit `ValidatorProtocol` for different types:

- `EmailValidatorProtocol`
- `PasswordValidatorProtocol`
- `NameValidatorProtocol`
- `DateOfBirthValidatorProtocol`
- `PhoneValidatorProtocol`

These protocols doesn't add methods, they are just useful for specific validators.
