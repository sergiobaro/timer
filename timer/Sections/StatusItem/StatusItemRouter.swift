import Cocoa

protocol StatusItemRouter {

  func showFinished()
  func closeFinished()
  func showTimeSelector(delegate: TimeSelectorDelegate)
  func closeTimeSelector()
  func closeOpenWindows()
  func quitApp()
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

    let viewController = TimerFinishedViewController()
    let popover = NSPopover()
    popover.contentViewController = viewController
    popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)

    timerFinishedPopover = popover
  }

  func closeFinished() {
    timerFinishedPopover?.close()
    timerFinishedPopover = nil
  }

  func showTimeSelector(delegate: TimeSelectorDelegate) {
    timeSelectorWindowController?.close()

    NSApplication.shared.activate(ignoringOtherApps: true)

    let windowController = TimeSeletorSectionBuilder().build(delegate: delegate)
    windowController?.window?.makeKeyAndOrderFront(self)
    windowController?.window?.center()

    timeSelectorWindowController = windowController
  }

  func closeTimeSelector() {
    timeSelectorWindowController?.close()
    timeSelectorWindowController = nil
  }

  func closeOpenWindows() {
    closeFinished()
    closeTimeSelector()
  }

  func quitApp() {
    NSApplication.shared.terminate(self)
  }
}
