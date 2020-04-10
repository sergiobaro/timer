import Cocoa
import TimeSelector
import TimeFinished

protocol StatusItemRouter {

  func showFinished()
  func closeFinished()
  func showTimeSelector(delegate: TimeSelectorDelegate)
  func closeTimeSelector()
  func closeOpenWindows()
  func quitApp()
}

class StatusItemRouterDefault: StatusItemRouter {

  private var timeFinishedPopover: NSPopover?
  private var timeSelectorWindowController: NSWindowController?

  private weak var statusItem: NSStatusItem?

  init(statusItem: NSStatusItem) {
    self.statusItem = statusItem
  }

  func showFinished() {
    guard let button = statusItem?.button else { return }

    let popover = NSPopover()
    popover.contentViewController = TimeFinishedSectionBuilder().build()
    popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)

    timeFinishedPopover = popover
  }

  func closeFinished() {
    timeFinishedPopover?.close()
    timeFinishedPopover = nil
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
