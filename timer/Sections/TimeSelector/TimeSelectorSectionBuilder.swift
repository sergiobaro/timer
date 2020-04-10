import Cocoa

class TimeSeletorSectionBuilder {

  func build(delegate: TimeSelectorDelegate) -> NSWindowController? {
    let storyboard = NSStoryboard(name: "TimeSelector", bundle: nil)
    guard let windowController = storyboard.instantiateInitialController() as? NSWindowController else {
      return nil
    }

    (windowController.contentViewController as? TimeSelectorViewController)?.delegate = delegate
    windowController.window?.styleMask.remove(.fullScreen)
    windowController.window?.styleMask.remove(.miniaturizable)
    windowController.window?.styleMask.remove(.resizable)

    return windowController
  }
}
