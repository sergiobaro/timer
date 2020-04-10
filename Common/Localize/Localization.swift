import Foundation

extension Bundle {
  static func `for`(_ object: AnyObject?) -> Bundle? {
    guard let object = object else { return nil }
    return Bundle(for: type(of: object))
  }
}

public func loc(_ key: String, _ object: AnyObject?) -> String {
  let bundle = Bundle.for(object) ?? .main
  return loc(key, bundle)
}

public func loc(_ key: String, _ bundle: Bundle) -> String {
  return NSLocalizedString(key, tableName: nil, bundle: bundle, value: "", comment: "")
}
