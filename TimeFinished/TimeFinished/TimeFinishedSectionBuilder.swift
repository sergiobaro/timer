import AppKit

public class TimeFinishedSectionBuilder {

  public init() { }

  public func build() -> NSViewController {
    let bundle = Bundle(for: type(of: self))
    return TimeFinishedViewController(nibName: "TimeFinishedViewController", bundle: bundle)
  }
}
