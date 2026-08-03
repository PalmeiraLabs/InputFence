# AGENTS.md

## Purpose

This file defines the engineering rules that every AI agent, contributor, and automated tool must follow when modifying this iOS project.

The main goals are:

- Maintain a clean, scalable, and testable Swift codebase.
- Enforce the SOLID principles.
- Keep classes and types small and focused.
- Require automated tests for all production logic.
- Maintain high test coverage.
- Prevent tightly coupled, hard-to-test implementations.
- Preserve consistency across the entire project.

These rules apply to all new code, refactors, bug fixes, and generated code.

---

## Core Engineering Principles

### 1. Follow SOLID Principles

All production code must respect the SOLID principles.

#### Single Responsibility Principle

Every class, struct, actor, enum, protocol, extension, and function must have one clear responsibility.

A type should have only one reason to change.

Avoid:

- Large view controllers.
- Large view models.
- Managers responsible for unrelated features.
- Services that perform networking, persistence, mapping, validation, and UI coordination in the same type.
- Utility classes that accumulate unrelated functions.

Prefer splitting responsibilities into focused components such as:

- API clients.
- Repositories.
- Use cases.
- Coordinators.
- Validators.
- Mappers.
- Formatters.
- Persistence services.
- Analytics services.
- Feature-specific view models.

#### Open/Closed Principle

Types should be open for extension but closed for modification.

Prefer:

- Protocol-based abstractions.
- Composition.
- Dependency injection.
- Strategy objects.
- Small interchangeable implementations.

Avoid adding large conditional branches every time a new behavior is introduced.

#### Liskov Substitution Principle

Any implementation of a protocol or subclass must be usable without changing the expected behavior of the consuming code.

Protocol conformances must honor the documented contract.

Do not create implementations that:

- Ignore required behavior.
- Throw unexpected errors.
- Require additional hidden preconditions.
- Return values that violate the protocol's documented expectations.

#### Interface Segregation Principle

Protocols must be small and focused.

Avoid large protocols that force conforming types to implement methods they do not need.

Prefer multiple focused protocols over a single broad protocol.

Example:

```swift
protocol UserFetching {
    func fetchUser(id: User.ID) async throws -> User
}

protocol UserSaving {
    func saveUser(_ user: User) async throws
}
```

#### Dependency Inversion Principle

High-level business logic must depend on abstractions, not concrete implementations.

Dependencies must be injected.

Avoid creating dependencies directly inside business logic.

Incorrect:

```swift
final class LoginViewModel {
    private let apiClient = APIClient()
}
```

Preferred:

```swift
final class LoginViewModel {
    private let authenticationService: AuthenticationServicing

    init(authenticationService: AuthenticationServicing) {
        self.authenticationService = authenticationService
    }
}
```

---

## Architecture

Use a clear, feature-oriented architecture.

Prefer organizing files by feature rather than placing all models, views, services, and view models in global folders.

Example:

```text
Features/
  Login/
    Domain/
      LoginUseCase.swift
      AuthenticationServicing.swift
    Data/
      AuthenticationService.swift
      LoginRequestDTO.swift
      LoginResponseDTO.swift
    Presentation/
      LoginView.swift
      LoginViewModel.swift
      LoginCoordinator.swift
    Tests/
      LoginUseCaseTests.swift
      LoginViewModelTests.swift

Core/
  Networking/
  Persistence/
  Analytics/
  Extensions/
  DesignSystem/
  TestingSupport/
```

Shared code must only be placed in `Core` or a shared module when it is genuinely reused by multiple features.

Do not move feature-specific code into global utility folders.

---

## Type Size and Complexity

Types must remain small and focused.

As a general guideline:

- A type should normally remain below 200 lines.
- A function should normally remain below 30 lines.
- A function should perform one logical operation.
- Deeply nested conditionals must be avoided.
- Complex conditions should be extracted into named properties or functions.
- Large types must be split before adding more responsibilities.

These are guidelines, not excuses for artificial fragmentation. Cohesion is more important than line count, but unusually large files require strong justification.

Avoid generic names such as:

- `Manager`
- `Helper`
- `Utils`
- `Common`
- `Handler`

Use names that describe the exact responsibility.

---

## Dependency Injection

All external dependencies must be injectable.

This includes:

- API clients.
- Repositories.
- Databases.
- File systems.
- Keychain access.
- Date providers.
- UUID generators.
- Notification centers.
- Analytics services.
- Location services.
- Reachability services.
- User defaults.
- Schedulers and clocks.

Prefer constructor injection.

Property injection should only be used when required by a framework.

Dependencies should normally be declared using protocols.

Default production implementations may be provided at the composition root, app entry point, dependency container, or coordinator layer.

Do not use global mutable state.

Avoid singletons unless the underlying Apple framework requires one. Even when wrapping a singleton framework, expose it through an injectable abstraction.

---

## Testability Requirements

All production logic must be testable.

Code must not depend directly on uncontrollable values such as:

- `Date()`
- `UUID()`
- `UserDefaults.standard`
- `URLSession.shared`
- `NotificationCenter.default`
- Static global state
- Random values
- Real network responses
- Real databases
- Real file system state

Wrap these dependencies behind abstractions when they affect behavior.

Example:

```swift
protocol DateProviding {
    var now: Date { get }
}

struct SystemDateProvider: DateProviding {
    var now: Date {
        Date()
    }
}
```

Tests must use deterministic mocks, spies, stubs, fakes, or in-memory implementations.

---

## Mandatory Testing Rules

Every production class or type containing behavior must have automated tests.

This includes:

- View models.
- Use cases.
- Services.
- Repositories.
- Coordinators with navigation logic.
- Validators.
- Mappers.
- Formatters.
- Persistence logic.
- Networking logic.
- Error mapping.
- State reducers.
- Business rules.
- Extensions containing non-trivial behavior.
- Concurrency logic.
- Custom UI components with meaningful behavior.

Simple data-only models may be excluded when they contain no behavior, validation, computed logic, or custom encoding/decoding.

Generated code and framework glue code may also be excluded when testing it would provide no meaningful value.

Every bug fix must include a regression test that fails before the fix and passes after the fix.

No production behavior should be added without corresponding tests.

---

## Test Coverage

The project must maintain high test coverage.

Targets:

- Overall line coverage should remain at or above 90%.
- Business logic, domain logic, use cases, validators, reducers, and view models should target 95% or higher.
- Critical flows such as authentication, payments, persistence, account management, and security-sensitive logic should target 100% branch coverage where practical.

Coverage must not be increased using meaningless tests.

Tests must verify behavior, outputs, state transitions, interactions, and error handling.

Do not write tests that only execute lines without asserting meaningful results.

Coverage exclusions must be explicit and justified.

New code must not reduce the project's existing coverage percentage.

---

## Test Organization

Tests must be organized by production type or feature.

Do not place all tests in one large test file.

Preferred naming:

```text
LoginViewModelTests.swift
AuthenticationServiceTests.swift
FetchUserUseCaseTests.swift
UserRepositoryTests.swift
EmailValidatorTests.swift
```

Each test file should focus on one system under test.

Use a clear structure:

```swift
final class LoginViewModelTests: XCTestCase {
    private var serviceSpy: AuthenticationServiceSpy!
    private var sut: LoginViewModel!

    override func setUp() {
        super.setUp()
        serviceSpy = AuthenticationServiceSpy()
        sut = LoginViewModel(authenticationService: serviceSpy)
    }

    override func tearDown() {
        sut = nil
        serviceSpy = nil
        super.tearDown()
    }
}
```

Use `sut` only when it improves clarity. Otherwise, use the concrete type name.

Test support types should be stored in a dedicated test support location when reused.

Example:

```text
Tests/
  TestDoubles/
  Fixtures/
  Builders/
  Helpers/
```

Do not expose test-only helpers in the production target.

---

## Test Naming

Test names must clearly describe:

- The condition.
- The action.
- The expected result.

Preferred formats:

```swift
func test_login_whenCredentialsAreValid_setsAuthenticatedState()
func test_loadUser_whenRepositoryFails_exposesError()
func test_submit_whenEmailIsInvalid_doesNotCallService()
```

The Arrange-Act-Assert structure should be easy to identify.

Example:

```swift
func test_load_whenServiceSucceeds_updatesUser() async {
    // Arrange
    serviceStub.result = .success(.fixture())

    // Act
    await sut.load()

    // Assert
    XCTAssertEqual(sut.user, .fixture())
    XCTAssertNil(sut.error)
}
```

---

## Test Doubles

Use the appropriate test double:

- Stub: provides predefined values.
- Spy: records interactions.
- Mock: verifies expected interactions.
- Fake: provides a lightweight working implementation.
- Dummy: satisfies a dependency that is not used.

Test doubles must be simple, deterministic, and local to the test target.

Avoid mocking implementation details.

Test observable behavior and meaningful collaborations.

---

## Required Test Scenarios

Tests must cover, when applicable:

- Successful execution.
- Failure paths.
- Boundary values.
- Empty values.
- Invalid input.
- Optional values.
- Loading states.
- Retry behavior.
- Cancellation.
- Duplicate requests.
- Unexpected server responses.
- Mapping failures.
- Persistence failures.
- Thread-safety.
- Main-thread UI updates.
- Async task cancellation.
- Race conditions.
- Memory management and retain cycles.
- State transitions.
- Idempotency.

---

## XCTest and Swift Testing

Use the testing framework already adopted by the project.

Do not mix XCTest and Swift Testing within the same feature without a clear project-level decision.

For new projects, Swift Testing may be preferred for unit tests when supported by the deployment and toolchain requirements.

XCTest remains appropriate for:

- UI tests.
- Performance tests.
- Existing XCTest-based suites.
- APIs not yet supported by Swift Testing.

Tests must be runnable locally and in CI.

---

## UI Testing

Critical user journeys must have UI tests.

Examples:

- App launch.
- Login and logout.
- Account creation.
- Main navigation.
- Form submission.
- Error recovery.
- Deep links.
- Purchase or payment flows.
- Accessibility-critical flows.

UI tests must not depend on real production services.

Use launch arguments, launch environments, mocked backends, or local test servers to create deterministic states.

Avoid fragile selectors based only on visible text.

All interactive elements should have stable accessibility identifiers.

---

## SwiftUI Rules

SwiftUI views should remain declarative and lightweight.

Views must not contain business logic, networking logic, persistence logic, or complex state transformations.

Prefer:

- Small reusable views.
- View models or observable state objects.
- Extracted formatting and mapping logic.
- Dependency injection through initializers or the environment.
- Explicit loading, success, empty, and failure states.

Do not create massive `body` implementations.

Extract subviews when they represent meaningful UI components.

Do not use `AnyView` unless type erasure is genuinely required.

Choose property wrappers intentionally:

- `@State` for view-owned local value state.
- `@Binding` for state owned by a parent.
- `@StateObject` for an observable object created and owned by the view.
- `@ObservedObject` for an observable object owned elsewhere.
- `@Environment` for values provided through the environment.
- `@EnvironmentObject` only for dependencies or shared state intentionally provided at a higher level.

View models containing logic must have unit tests.

Important SwiftUI views should have snapshot tests when the project supports them.

---

## UIKit Rules

View controllers must remain focused on:

- View lifecycle.
- Binding UI state.
- Forwarding user actions.
- Coordinating presentation.
- Rendering view model output.

View controllers must not contain:

- Networking.
- Persistence.
- Business rules.
- Data mapping.
- Validation logic.
- Complex navigation decisions.

Use coordinators or routers for navigation when navigation logic becomes non-trivial.

Custom views must not own business logic.

---

## Concurrency

Prefer Swift Concurrency for asynchronous code.

Use:

- `async` and `await`.
- Structured concurrency.
- Actors for isolated mutable state.
- Explicit cancellation handling.
- `@MainActor` for UI-facing state.

Avoid:

- Unstructured tasks without lifecycle ownership.
- Detached tasks unless clearly justified.
- Manual thread synchronization when actors are sufficient.
- Updating UI state from background executors.
- Ignoring cancellation.

Concurrency-sensitive code must have tests covering:

- Cancellation.
- Multiple simultaneous calls.
- Ordering.
- Isolation.
- Duplicate execution.
- Race conditions.

Do not use arbitrary sleeps in tests.

Use expectations, controllable clocks, continuations, test schedulers, or deterministic synchronization.

---

## Error Handling

Errors must be explicit and meaningful.

Do not silently ignore errors.

Avoid empty `catch` blocks.

Map infrastructure errors into domain-level errors when appropriate.

User-facing errors must not expose internal implementation details, server payloads, tokens, or sensitive information.

Tests must cover expected failure cases.

---

## Networking

Networking code must be separated from presentation and business logic.

A networking layer should clearly separate:

- Request construction.
- Transport.
- Response validation.
- Decoding.
- DTO-to-domain mapping.
- Error mapping.

Do not expose transport DTOs directly to the UI or domain layer unless they are intentionally the same model.

Use injectable networking abstractions.

Do not call `URLSession.shared` directly from feature logic.

Networking tests must not call real external APIs.

---

## Persistence

Persistence logic must be hidden behind repository or storage abstractions.

Feature code must not directly depend on:

- Core Data implementation details.
- SwiftData implementation details.
- Realm implementation details.
- UserDefaults keys.
- Keychain implementation details.
- File paths.

Use in-memory fakes for unit tests.

Persistence migrations and data mapping must be tested.

Sensitive data must use appropriate secure storage.

---

## Security

Never hardcode:

- API keys.
- Private tokens.
- Passwords.
- Secrets.
- Signing credentials.
- Sensitive endpoints.
- Personal data.

Do not log sensitive information.

Use Keychain or another approved secure storage mechanism for credentials and tokens.

Validate all external input.

Use secure transport.

Do not disable TLS validation.

Security-sensitive logic must have dedicated tests.

---

## Code Style

Follow the project's SwiftLint, SwiftFormat, and compiler settings.

General rules:

- Prefer `let` over `var`.
- Use explicit access control.
- Default to `private` whenever possible.
- Prefer value types unless reference semantics are required.
- Mark classes `final` unless subclassing is intentionally supported.
- Avoid force unwrapping.
- Avoid force casts.
- Avoid `try!`.
- Avoid implicitly unwrapped optionals outside framework-required lifecycle cases.
- Use guard statements for invalid preconditions and early exits.
- Keep functions cohesive.
- Use meaningful names.
- Avoid abbreviations unless they are well-known in the domain.
- Remove dead code.
- Remove commented-out code.
- Do not leave debug prints in production code.

Warnings must be treated as errors whenever project configuration allows it.

---

## Documentation

Public APIs and non-obvious behavior must be documented.

Documentation should explain:

- Intent.
- Contracts.
- Preconditions.
- Side effects.
- Threading or actor expectations.
- Error behavior.
- Security implications.

Do not add comments that merely repeat the code.

Use documentation comments for reusable modules and public interfaces.

Architectural decisions that affect multiple features should be recorded in an ADR or equivalent project documentation.

---

## Accessibility

Accessibility is mandatory.

All interactive controls must provide meaningful accessibility labels, traits, values, hints, or identifiers when needed.

Support:

- VoiceOver.
- Dynamic Type.
- Sufficient contrast.
- Reduced Motion.
- Larger accessibility text sizes.
- Keyboard navigation when relevant.
- Clear focus order.

Accessibility behavior should be covered by tests where practical.

---

## Performance

Avoid premature optimization, but do not introduce obvious performance problems.

Be cautious with:

- Expensive work on the main actor.
- Repeated image decoding.
- Large object graphs.
- Unbounded caches.
- Repeated view recomputation.
- Excessive network calls.
- N+1 persistence queries.
- Large synchronous file operations.
- Retain cycles.

Performance-sensitive code should include performance tests when regressions would materially affect the application.

---

## Memory Management

Closures must use capture semantics intentionally.

Use `[weak self]` only when the closure should not retain the object.

Do not use `[weak self]` automatically without understanding object ownership.

Use `unowned` only when the lifetime relationship guarantees safety.

Delegates should usually be weak when ownership belongs to the delegating object.

Long-lived tasks, publishers, callbacks, and observers must be cancelled or removed appropriately.

Tests should verify deallocation for components at risk of retain cycles.

---

## Pull Request Requirements

Before considering a change complete:

- The project must compile without warnings.
- All tests must pass.
- New behavior must have tests.
- Bug fixes must have regression tests.
- Test coverage must not decrease.
- SOLID principles must be respected.
- New dependencies must be justified.
- Public APIs must be documented.
- No secrets or sensitive data may be committed.
- No dead or commented-out code may remain.
- Accessibility identifiers must be added for UI-tested elements.
- Architecture and folder conventions must be preserved.

A change is not complete merely because it compiles.

---

## Continuous Integration

CI must validate:

- Build success.
- Unit tests.
- UI tests for critical flows.
- Code coverage.
- SwiftLint.
- SwiftFormat or formatting validation.
- Dependency resolution.
- Static analysis when available.

The CI pipeline must fail when:

- Tests fail.
- Coverage falls below the agreed threshold.
- Linting fails.
- Formatting is invalid.
- Compiler warnings are introduced.
- Required generated files are outdated.

---

## Agent Behavior

When modifying the project, an AI agent must:

1. Inspect the existing architecture before writing code.
2. Reuse established patterns unless they are clearly defective.
3. Avoid introducing a second architecture for the same responsibility.
4. Identify the production type and corresponding test file before making changes.
5. Add or update tests together with production code.
6. Run the relevant test suite after each meaningful change.
7. Run the complete test suite before finishing.
8. Report any tests that could not be executed.
9. Never claim tests passed unless they were actually executed successfully.
10. Never lower coverage thresholds to make CI pass.
11. Never delete failing tests without proving that they are obsolete.
12. Never weaken assertions merely to obtain a passing result.
13. Avoid broad refactors unrelated to the requested task.
14. Preserve backward compatibility unless a breaking change is explicitly approved.
15. Clearly document assumptions and trade-offs.

---

## Definition of Done

A task is complete only when:

- The implementation follows SOLID principles.
- Responsibilities are properly separated.
- Dependencies are injected.
- Production logic is testable.
- All relevant classes and behaviors have tests.
- Success, failure, and boundary scenarios are covered.
- The full test suite passes.
- Coverage remains at or above the required threshold.
- The code builds without warnings.
- No security, accessibility, or memory-management regressions are introduced.
- The implementation is documented where necessary.
- CI requirements are satisfied.

Code that lacks appropriate tests or violates these rules must not be considered complete.

## Swift Package Manager Framework Rules

This project is distributed as a Swift Package Manager package. All changes must preserve package integrity, public API stability, and compatibility with supported platforms and Swift toolchains.

### Package Manifest

The `Package.swift` manifest must remain valid and minimal.

Rules:

* Do not add dependencies unless they are necessary and justified.
* Prefer stable package versions over branch-based dependencies.
* Avoid exact version pinning unless there is a documented reason.
* Use semantic version ranges whenever possible.
* Do not expose internal implementation targets as public products.
* Keep platform declarations explicit.
* Keep the minimum supported platform versions as low as reasonably possible.
* Do not increase minimum deployment targets without explicit approval.
* Do not modify the Swift tools version unless required and reviewed.
* Validate the package using:

```bash
swift package resolve
swift build
swift test
```

When the package supports Apple platforms only, also validate it with Xcode.

---

### Package Structure

The package should follow a clear target structure.

Example:

```text
Package.swift

Sources/
  FrameworkName/
    Public/
    Internal/
    Domain/
    Infrastructure/

Tests/
  FrameworkNameTests/
    Unit/
    Integration/
    TestDoubles/
    Fixtures/
```

If the package contains multiple targets, each target must have a clear responsibility.

Avoid:

* Circular dependencies between targets.
* A single target containing unrelated functionality.
* Public exposure of implementation-only targets.
* Placing test helpers in production targets.

Test-only utilities must remain inside test targets or dedicated testing-support targets that are not shipped as part of the public product.

---

### Public API Design

Public API design must be intentional and conservative.

Every `public` or `open` declaration becomes part of the package contract.

Rules:

* Default to `internal`.
* Use `public` only when consumers must access the declaration.
* Avoid `open` unless external subclassing is explicitly supported.
* Prefer `public final class` over `open class`.
* Prefer protocols and value types for stable abstractions.
* Do not expose internal infrastructure types.
* Do not expose transport DTOs, persistence models, or implementation details.
* Avoid exposing third-party dependency types in the public API.
* Prefer package-owned abstractions instead.
* Public APIs must have documentation comments.
* Public errors must be documented.
* Public async behavior, thread-safety, and actor isolation must be documented.
* Public types must have predictable naming and consistent semantics.

Before adding a public declaration, ask whether the same behavior can remain internal.

---

### API Stability

Changes to public APIs must be treated carefully.

Potentially breaking changes include:

* Renaming public types, methods, properties, enum cases, or parameters.
* Removing public declarations.
* Changing parameter labels.
* Changing return types.
* Changing generic constraints.
* Changing protocol requirements.
* Changing nullability.
* Changing throwing behavior.
* Changing actor isolation.
* Changing synchronous APIs to asynchronous APIs.
* Changing value semantics to reference semantics.
* Changing default behavior.
* Increasing minimum supported platform versions.

Breaking changes require:

* Explicit approval.
* A major semantic version increment.
* Migration documentation.
* Updated examples and tests.

Do not introduce breaking changes in minor or patch releases.

---

### Semantic Versioning

The package must follow Semantic Versioning.

* Patch release: backward-compatible bug fixes.
* Minor release: backward-compatible new functionality.
* Major release: breaking API changes.

Do not mark a change as backward-compatible only because the project compiles internally.

Compatibility must be evaluated from the perspective of external package consumers.

---

### Library Evolution and Binary Compatibility

If the package is distributed as source through Swift Package Manager, source compatibility is the primary requirement.

If the framework is also distributed as a binary framework or XCFramework:

* Enable library evolution when required.
* Use `BUILD_LIBRARY_FOR_DISTRIBUTION` where appropriate.
* Avoid exposing non-resilient implementation details.
* Validate module stability.
* Validate binary compatibility across supported toolchains.
* Do not assume source compatibility guarantees binary compatibility.

---

### Supported Platforms

All supported platforms must be declared explicitly in `Package.swift`.

Example:

```swift
platforms: [
    .iOS(.v15),
    .macOS(.v12)
]
```

Platform-specific code must use appropriate conditional compilation:

```swift
#if os(iOS)
#endif
```

or:

```swift
#if canImport(UIKit)
#endif
```

Prefer `canImport` when support depends on framework availability rather than the operating system name.

Platform-specific implementations should be isolated behind shared abstractions.

Do not scatter conditional compilation throughout business logic.

---

### Swift Version Compatibility

The package must compile with all officially supported Swift versions.

Avoid using language or standard-library features unavailable in the minimum supported Swift version.

When adopting a newer Swift feature:

* Confirm package toolchain requirements.
* Update CI to test the new version.
* Document compatibility changes.
* Avoid forcing consumers to upgrade without necessity.

When practical, CI should test more than one Swift toolchain version.

---

### External Dependencies

Dependencies must be minimized.

Before adding a dependency, evaluate:

* Maintenance status.
* License.
* Package size.
* Transitive dependencies.
* Supported platforms.
* Supported Swift versions.
* Security history.
* Public API exposure.
* Whether the functionality can be implemented safely with the standard library or Apple frameworks.

Do not expose dependency-specific types in the package's public API.

All dependency usage must be isolated behind internal abstractions.

This makes it possible to replace or remove the dependency without breaking package consumers.

---

### Resources

Package resources must be declared explicitly in `Package.swift`.

Example:

```swift
resources: [
    .process("Resources")
]
```

Access package resources using:

```swift
Bundle.module
```

Do not use `Bundle.main` for resources owned by the package.

Resource loading must be tested.

Resource names must avoid collisions and should be scoped clearly.

---

### Concurrency and Sendable

Public concurrency APIs must be safe and explicit.

Rules:

* Use `Sendable` where appropriate.
* Avoid exposing mutable shared state.
* Document actor isolation.
* Mark UI-only APIs with `@MainActor`.
* Avoid unchecked `Sendable` conformances.
* Use `@unchecked Sendable` only with documented synchronization guarantees.
* Test concurrent access to public APIs.
* Ensure public closures have appropriate `@Sendable` annotations when required.

Concurrency warnings must not be ignored.

The package should compile under strict concurrency checking when supported by the project toolchain.

---

### Public Protocols

Public protocols require special care because adding a new requirement may break conforming consumers.

Prefer:

* Small protocols.
* Stable requirements.
* Default implementations when behavior is genuinely optional.
* Capability-specific protocols.

Avoid public protocols when external conformance is not intended.

When external conformance should not be supported, prefer a concrete public type or document the restriction clearly.

---

### Errors

Public errors must be stable and meaningful.

Rules:

* Do not expose raw `NSError`, transport errors, database errors, or third-party errors directly.
* Map internal failures to package-owned error types.
* Avoid changing documented error semantics in minor releases.
* Use associated values only when consumers need the additional context.
* Do not include secrets, tokens, or sensitive data in error descriptions.

Tests must verify public error mapping.

---

### Documentation and Examples

Every public API must have documentation comments.

The package should include:

* A clear `README.md`.
* Installation instructions.
* Minimum platform requirements.
* Supported Swift versions.
* Usage examples.
* Error-handling examples.
* Concurrency notes.
* Migration notes for breaking changes.
* A license file.
* A changelog when the package is versioned publicly.

Code examples in documentation must compile.

Important public usage examples should be covered by tests when practical.

If DocC is used:

* Public APIs must appear in the documentation catalog.
* Tutorials and articles must be kept synchronized with the implementation.
* Documentation builds must be validated in CI.

---

### Consumer-Facing Tests

In addition to unit tests, the package must include tests that simulate external usage.

Consumer-facing tests should:

* Import the package using its public module.
* Avoid `@testable import` when validating public behavior.
* Verify that public initializers and methods are usable.
* Verify public API visibility.
* Verify common integration scenarios.
* Detect accidental reliance on internal APIs.

Both types of tests may be used:

```swift
@testable import FrameworkName
```

for internal unit testing, and:

```swift
import FrameworkName
```

for public API and consumer-facing testing.

---

### Package Integration Tests

The package must be validated as a dependency of a separate sample or fixture application when practical.

Integration validation should cover:

* Adding the package through Swift Package Manager.
* Resolving dependencies.
* Importing the public module.
* Building an application that consumes the package.
* Using public APIs from another target.
* Resource loading.
* Supported platform compilation.

A package that only builds inside its own repository is not sufficiently validated.

---

### Test Coverage for Packages

Coverage must include all package targets containing production behavior.

Recommended targets:

* Overall package coverage: at least 90%.
* Core business and public behavior: at least 95%.
* Critical public APIs: as close to 100% as practical.
* Error mapping and compatibility behavior: 100% where practical.

Generated files, trivial data containers, and platform glue may be excluded only with explicit justification.

Do not exclude difficult code merely to improve the reported percentage.

---

### API Compatibility Validation

When tooling is available, CI should validate public API compatibility.

Possible checks include:

* Public API symbol graph generation.
* Comparison against the previous released API.
* Detection of removed or changed public declarations.
* Compilation of consumer fixtures.
* Documentation build validation.

Accidental public API changes must fail CI when possible.

---

### Build Configurations

The package must compile in both debug and release configurations.

Run:

```bash
swift build
swift build -c release
swift test
```

Release-only compilation errors must be treated as blocking.

Optimization-related behavior must not change the public contract.

---

### Warnings and Diagnostics

The package must compile without warnings.

Warnings generated by:

* The Swift compiler.
* Strict concurrency checking.
* SwiftLint.
* SwiftFormat validation.
* Documentation generation.
* Package resolution.

must be resolved rather than suppressed, unless the suppression is documented and justified.

Do not use broad warning suppression flags.

---

### Package Manager Restrictions

Do not rely on:

* Xcode workspace-only configuration.
* Application target build settings.
* `Bundle.main`.
* App-specific environment assumptions.
* Implicit resources.
* Headers or modules not declared by the package.
* Local file paths.
* Undeclared system dependencies.
* Manual framework linking performed only in Xcode.

The package must remain reproducible through `Package.swift`.

---

### Release Checklist

Before publishing a new package version:

* Confirm that `Package.swift` is valid.
* Confirm all dependencies resolve.
* Run all tests.
* Verify coverage requirements.
* Build in debug and release configurations.
* Build all supported platforms.
* Verify public documentation.
* Verify the README examples.
* Check public API compatibility.
* Update the changelog.
* Confirm the semantic version increment is correct.
* Confirm the Git tag matches the release version.
* Verify that no secrets, local paths, or development-only files are included.
* Validate integration from an external consumer target.

A release must not be created from an unclean or unverified state.

---

### Additional Agent Rules for Swift Packages

When modifying this Swift package, an AI agent must:

1. Inspect `Package.swift` before changing package structure.
2. Identify all affected targets and products.
3. Preserve public API compatibility unless a breaking change is explicitly requested.
4. Avoid making declarations public only to simplify tests.
5. Add tests for both internal behavior and public consumer behavior.
6. Validate package resolution after dependency changes.
7. Build in both debug and release configurations.
8. Test supported platforms when tooling is available.
9. Update public documentation when public behavior changes.
10. Report any compatibility, platform, or toolchain assumptions.
11. Never increase minimum platform requirements without explicit approval.
12. Never introduce a dependency that becomes visible in the public API.
13. Never use `Bundle.main` for package-owned resources.
14. Never claim package compatibility without building or testing it.
15. Never publish or tag a release unless explicitly requested.
