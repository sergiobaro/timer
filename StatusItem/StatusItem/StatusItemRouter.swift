import Cocoa
import TimeSelector
import History

protocol StatusItemRouter {

  func showTimeSelector(delegate: TimeSelectorDelegate)
  func closeTimeSelector()

  func showHistory()
  func closeHistory()

  func closeOpenWindows()
  func activatePreviousApp()
  func quitApp()
}

class StatusItemRouterDefault: StatusItemRouter {

  private var timeSelectorWindowController: NSWindowController?
  private var historyWindowController: NSWindowController?

  private weak var statusItem: NSStatusItem?

  init(statusItem: NSStatusItem) {
    self.statusItem = statusItem
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

    historyWindowController = HistoryFactory.makeViewController()
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
    closeTimeSelector()
    closeHistory()
  }

  func activatePreviousApp() {
    let app = NSWorkspace.shared.menuBarOwningApplication
    app?.activate()
  }

  func quitApp() {
    NSApplication.shared.terminate(self)
  }
}
