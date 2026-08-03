@testable import InputFence

struct ValidatorStub: ValidatorProtocol {
    var acceptedValue: String?

    func isValid(_ value: String) -> Bool {
        guard let acceptedValue else { return true }
        return value == acceptedValue
    }
}
