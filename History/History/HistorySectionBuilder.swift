import Cocoa

class HistorySectionBuilder {

  func build() -> NSWindowController? {
    let bundle = Bundle(for: type(of: self))
    let storyboard = NSStoryboard(name: "History", bundle: bundle)
    guard let windowController = storyboard.instantiateInitialController() as? NSWindowController else {
      return nil
    }

    windowController.window?.styleMask.remove(.fullScreen)
    windowController.window?.styleMask.remove(.miniaturizable)
    windowController.window?.styleMask.remove(.resizable)

    return windowController
  }
}
