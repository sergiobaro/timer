import Cocoa

class TimeSeletorSectionBuilder {
  
  func build(delegate: TimeSelectorDelegate) -> NSWindowController {
    let windowController = NSStoryboard(name: "TimeSelector", bundle: nil).instantiateInitialController() as! NSWindowController
    
    (windowController.contentViewController as! TimeSelectorViewController).delegate = delegate
    windowController.window?.styleMask.remove(.fullScreen)
    windowController.window?.styleMask.remove(.miniaturizable)
    windowController.window?.styleMask.remove(.resizable)
    
    return windowController
  }
}
