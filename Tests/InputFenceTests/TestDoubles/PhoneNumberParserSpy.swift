@testable import InputFence

final class PhoneNumberParserSpy: PhoneNumberParsing {
    private(set) var parsedValues: [(value: String, region: String)] = []
    var canParseResult = true

    func canParse(_ value: String, region: String) -> Bool {
        parsedValues.append((value, region))
        return canParseResult
    }
}
