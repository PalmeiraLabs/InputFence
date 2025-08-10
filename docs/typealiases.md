# Validator Typealiases

These typealiases provide convenient names for specific validators:

```swift
public typealias EmailValidator<T: EmailValidatorProtocol> = FieldValidator<T>
public typealias PasswordValidator<T: PasswordValidatorProtocol> = FieldValidator<T>
public typealias NameValidator<T: NameValidatorProtocol> = FieldValidator<T>
public typealias UsernameValidator<T: NameValidatorProtocol> = FieldValidator<T>
public typealias PhoneValidator<T: PhoneValidatorProtocol> = FieldValidator<T>
```

