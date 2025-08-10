# ValidatorProtocol

The `ValidatorProtocol` defines the base interface for any type of validator.

## Declaration

```swift
public protocol ValidatorProtocol {
    func isValid(_ value: String) -> Bool
}
```

## Overview

Any type conforming to this protocol must implement the `isValid(_:)` method to determine whether a given string value meets the expected validation rules.

