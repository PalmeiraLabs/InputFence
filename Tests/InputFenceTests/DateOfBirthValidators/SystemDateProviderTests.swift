import Foundation
import XCTest
@testable import InputFence

final class SystemDateProviderTests: XCTestCase {
    func test_now_whenRead_returnsCurrentSystemDate() {
        let provider = SystemDateProvider()

        let before = Date()
        let now = provider.now
        let after = Date()

        XCTAssertGreaterThanOrEqual(now, before)
        XCTAssertLessThanOrEqual(now, after)
    }
}
