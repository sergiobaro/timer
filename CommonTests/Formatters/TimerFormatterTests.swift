import XCTest
@testable import Common
import Nimble

class TimerFormatterTests: XCTestCase {

  func test_format() {
    let formatter = TimerFormatter()

    expect(formatter.format(0)).to(equal("00:00"))
    expect(formatter.format(1)).to(equal("00:01"))
    expect(formatter.format(30)).to(equal("00:30"))
    expect(formatter.format(1.5 * 60)).to(equal("01:30"))
    expect(formatter.format(25 * 60)).to(equal("25:00"))
    expect(formatter.format(60 * 60)).to(equal("1:00:00"))
    expect(formatter.format(1.5 * 60 * 60)).to(equal("1:30:00"))
  }

  func test_format_from() {
    let formatter = TimerFormatter()

    expect(formatter.format(0, from: 1 * 60 * 60)).to(equal("0:00:00"))
    expect(formatter.format(0, from: 1 * 60)).to(equal("00:00"))
  }
}
