import Cocoa

public protocol TimeSelectorDelegate: class {

  func timeSelectorDidSelect(name: String, timeInterval: TimeInterval)
}

public class TimeSeletorSectionBuilder {

  public init() { }

  public func build(delegate: TimeSelectorDelegate) -> NSWindowController? {
    let bundle = Bundle(for: type(of: self))
    let storyboard = NSStoryboard(name: "TimeSelector", bundle: bundle)
    guard let windowController = storyboard.instantiateInitialController() as? NSWindowController else {
      return nil
    }

    (windowController.contentViewController as? TimeSelectorViewController)?.delegate = delegate
    windowController.window?.styleMask.remove(.resizable)

    return windowController
  }
}
