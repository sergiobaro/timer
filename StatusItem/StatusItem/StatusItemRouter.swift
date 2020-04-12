import Cocoa
import TimeSelector
import TimeFinished
import History

protocol StatusItemRouter {

  func showFinished()
  func closeFinished()

  func showTimeSelector(delegate: TimeSelectorDelegate)
  func closeTimeSelector()

  func showHistory()
  func closeHistory()

  func closeOpenWindows()
  func quitApp()
}

class StatusItemRouterDefault: StatusItemRouter {

  private var timeFinishedPopover: NSPopover?
  private var timeSelectorWindowController: NSWindowController?
  private var historyWindowController: NSWindowController?

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

  func showHistory() {
    historyWindowController?.close()
    NSApplication.shared.activate(ignoringOtherApps: true)

    historyWindowController = HistoryFactory().makeViewController()
    historyWindowController?.window?.makeKeyAndOrderFront(self)
    historyWindowController?.window?.center()
  }

  func closeHistory() {
    historyWindowController?.close()
    historyWindowController = nil
  }

  func closeTimeSelector() {
    timeSelectorWindowController?.close()
    timeSelectorWindowController = nil
  }

  func closeOpenWindows() {
    closeFinished()
    closeTimeSelector()
    closeHistory()
  }

  func quitApp() {
    NSApplication.shared.terminate(self)
  }
}
