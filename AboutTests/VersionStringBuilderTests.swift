import XCTest
import Nimble
@testable import About

class VersionStringBuilderTests: XCTestCase {

  struct BundleVersion: BundleProxy {
    let version: String?
    let buildNumber: String?
  }

  func test_versionString_versionAndBuildNumber() {
    let bundle = BundleVersion(version: "1.37.0", buildNumber: "123")
    let version = VersionStringBuilder().build(bundle: bundle)
    expect(version).to(equal("Version: 1.37.0 (123)"))
  }

  func test_versionString_onlyVersion() {
    let bundle = BundleVersion(version: "1.0", buildNumber: nil)
    let version = VersionStringBuilder().build(bundle: bundle)
    expect(version).to(equal("Version: 1.0"))
  }

  func test_versionString_empty() {
    let bundle = BundleVersion(version: nil, buildNumber: nil)
    let version = VersionStringBuilder().build(bundle: bundle)
    expect(version).to(equal(""))
  }
}
