import XCTest
@testable import InputFence

final class PhoneNumberKitParserTests: XCTestCase {
    func test_canParse_whenPhoneNumberIsValidForRegion_returnsTrue() {
        let parser = PhoneNumberKitParser()

        XCTAssertTrue(parser.canParse("6505551234", region: "US"))
    }

    func test_canParse_whenPhoneNumberIsInvalidForRegion_returnsFalse() {
        let parser = PhoneNumberKitParser()

        XCTAssertFalse(parser.canParse("123", region: "US"))
    }
}
