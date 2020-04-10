import Cocoa

protocol StatusItemRouter {
  
  func showFinished()
  func hideFinished()
  func showTimeSelector(delegate: TimeSelectorDelegate)
}

class StatusItemRouterDefault: StatusItemRouter {
  
  private var timerFinishedPopover: NSPopover?
  private var timeSelectorWindowController: NSWindowController?
  
  private weak var statusItem: NSStatusItem?
  
  init(statusItem: NSStatusItem) {
    self.statusItem = statusItem
  }
  
  func showFinished() {
    guard let button = statusItem?.button else { return }
    
    let vc = TimerFinishedViewController()
    let popover = NSPopover()
    popover.contentViewController = vc
    popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
    
    timerFinishedPopover = popover
  }
  
  func hideFinished() {
    timerFinishedPopover?.close()
    timerFinishedPopover = nil
  }
  
  func showTimeSelector(delegate: TimeSelectorDelegate) {
    timeSelectorWindowController?.close()
    
    NSApplication.shared.activate(ignoringOtherApps: true)
    
    let windowController = TimeSeletorSectionBuilder().build(delegate: delegate)
    windowController.window?.makeKeyAndOrderFront(self)
    windowController.window?.center()
    
    timeSelectorWindowController = windowController
  }
}
