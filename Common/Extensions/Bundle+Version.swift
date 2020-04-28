import Foundation

public extension Bundle {

  var version: String? {
    object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
  }

  var buildNumber: String? {
    object(forInfoDictionaryKey: "CFBundleVersion") as? String
  }
}
