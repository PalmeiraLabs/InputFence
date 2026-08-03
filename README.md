# InputFence
InputFence is a lightweight and flexible Swift Package designed to simplify user input validation in any iOS, macOS, watchOS, or tvOS application.  
It provides ready-to-use validators for common fields such as **email addresses, passwords, phone numbers, usernames, first names, last names, and dates of birth**, while allowing you to configure parameters to fit your specific needs. 

Built for clean architectures, reusable logic, and full SwiftPM support.

Supported platforms: iOS 12+, macOS 10.13+, tvOS 12+, and watchOS 4+.

---

## ✨ Features

- ✅ **Prebuilt Validators** – Quickly validate common input types.
- ⚙️ **Configurable Parameters** – Adjust rules such as min/max lengths, allowed characters, and age ranges.
- 🛠 **Protocol-Oriented Design** – Easy to extend and create your own custom validators.
- 📦 **Swift Package Manager Support** – Simple integration into any project.
- 🌍 **Locale-Aware** – Handles formats like date of birth parsing with regional settings.

---

## 📦 Installation

### Swift Package Manager

1. In Xcode, go to **File > Add Packages...**
2. Enter the repository URL:
   ```
   https://github.com/PalmeiraLabs/InputFence
   ```
3. Select the version and add it to your project.

---

## 🚀 Usage

### Example – Validating a Date of Birth

```swift
import InputFence

let validator = AdvancedDateOfBirthValidator(
    parameters: DateOfBirthValidatorParameters(minAge: 18, maxAge: 99)
)

if validator.isValid("12/08/1995") {
    print("Valid date of birth ✅")
} else {
    print("Invalid date of birth ❌")
}
```

### Example – Validating a Username

```swift
import InputFence

let usernameRules = NameValidatorParameters(
    minAmountOfCharacters: 3,
    maxAmountOfCharacters: 20,
    shouldHaveOnlyLetters: false
)

let validator = UsernameValidator(
    validator: AdvancedNameValidator(parameters: usernameRules),
    value: "Agustin"
)

if validator.isValid() {
    print("Valid username ✅")
} else {
    print("Invalid username ❌")
}
```

### Usage examples

```swift
import InputFence

// Example 1: Validate an email using the simple validator
let emailValidator = SimpleEmailValidator()
print(emailValidator.isValid("user@example.com")) // true
print(emailValidator.isValid("invalid-email"))    // false

// Example 2: Use an advanced password validator with custom parameters
let passwordParams = PasswordValidatorParameters(
    minAmountOfCharacters: 8,
    maxAmountOfCharacters: 30,
    minAmountOfSpecialCharacters: 1,
    minAmountOfNumbers: 1
)
let passwordValidator = AdvancedPasswordValidator(parameters: passwordParams)
print(passwordValidator.isValid("P@ssword1")) // true

// Example 3: Use the generic wrapper to validate a field
let wrappedEmail = EmailValidator(
    validator: SimpleEmailValidator(),
    value: "contact@domain.com"
)
print(wrappedEmail.isValid()) // true

// Example 4: Use the generic wrapper to validate passwords
let wrappedPassword = PasswordValidator(
    validator: passwordValidator,
    value: "1234"
)
print(wrappedPassword.isValid()) // false
```

## Tips

- You can instantiate a specific validator directly (e.g., SimpleEmailValidator().isValid(...)).
- You can wrap a specific validator inside your generic FieldValidator (e.g., EmailValidator(...) or PasswordValidator(...)).
- You can pass custom parameters (as in AdvancedPasswordValidator).
- FieldValidator<T> → Generic that accepts any validation protocol implementation.
- Typealiases (EmailValidator, PasswordValidator, etc.) → Typed versions for each data type.
- Protocols (EmailValidatorProtocol, etc.) → Define the validation rules.
- Concrete implementations (SimpleEmailValidator, AdvancedPasswordValidator, etc.) → Actual validation logic.

## 📚 Documentation

For detailed guides, API reference, and validator specifications, check out the full documentation:

- **Online Docs** → [InputFence Documentation](https://palmeiralabs.github.io/InputFence/)  
- **Local Docs**  
  1. Clone this repository.
  2. Install MkDocs (if you don’t have it):
     ```bash
     pip install mkdocs-material
     ```
  3. Serve the documentation locally:
     ```bash
     mkdocs serve -f docs/mkdocs.yml
     ```
  4. Open `http://127.0.0.1:8000` in your browser.

Documentation source files are located in the [`docs/docs/`](docs/docs/) directory and include:
- **Validators** → Usage of each built-in validator.
- **Protocols** → Interfaces and extension points.
- **Parameters** → Customization and configuration options.

---

## 📄 License

This project is licensed under the MIT License – see the [LICENSE](LICENSE) file for details.

## Author

Agustin Palmeira / PalmeiraLabs

## 📬 Contact

Feel free to reach out with questions, feedback, or licensing inquiries:

📧 **agustin.palmeira.it@gmail.com**  
🔗 https://www.linkedin.com/in/agustin-daniel-palmeira/
