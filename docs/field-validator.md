# FieldValidator

The `FieldValidator` is a generic structure that works with any validator conforming to `ValidatorProtocol`.

## Declaration

```swift
public struct FieldValidator<T: ValidatorProtocol> {
    private var validator: T
    private var value: String

    public init(validator: T, value: String) {
        self.validator = validator
        self.value = value
    }

    public mutating func config(validator: T, value: String) {
        self.validator = validator
        self.value = value
    }

    public func isValid() -> Bool {
        return validator.isValid(self.value)
    }
}
```

## Overview

`FieldValidator` holds both the validator instance and the value to be validated.  
It provides an `isValid()` method to check whether the stored value passes the given validator's rules.

