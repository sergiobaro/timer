import Foundation
import Common

protocol BundleProxy {
  var version: String? { get }
  var buildNumber: String? { get }
}

extension Bundle: BundleProxy {
  var version: String? {
    object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
  }

  var buildNumber: String? {
    object(forInfoDictionaryKey: "CFBundleVersion") as? String
  }
}

class VersionStringBuilder {

  func build(bundle: BundleProxy) -> String {
    let versionFormat = loc("about.version.format", self)
    let versionString = buildVersionString(bundle: bundle)

    if versionString.isEmpty { return ""}

    return String(format: versionFormat, versionString)
  }

  private func buildVersionString(bundle: BundleProxy) -> String {
    guard let appVersion = bundle.version else {
      return ""
    }
    guard let buildNumber = bundle.buildNumber else {
      return appVersion
    }

    return "\(appVersion) (\(buildNumber))"
  }
}
