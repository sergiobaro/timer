import Cocoa
import TimeSelector
import History
import About

protocol StatusItemRouter {

  func showTimeSelector(delegate: TimeSelectorDelegate)
  func closeTimeSelector()

  func showHistory()
  func closeHistory()

  func showAbout()
  func closeAbout()

  func closeOpenWindows()
  func activatePreviousApp()
  func quitApp()
}

class StatusItemRouterDefault: StatusItemRouter {

  private var timeSelectorWindowController: NSWindowController?
  private var historyWindowController: NSWindowController?
  private var aboutWindowController: NSWindowController?

  private weak var statusItem: NSStatusItem?

  init(statusItem: NSStatusItem) {
    self.statusItem = statusItem
  }

  func showTimeSelector(delegate: TimeSelectorDelegate) {
    closeTimeSelector()
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

  func showHistory() {
    closeHistory()
    NSApplication.shared.activate(ignoringOtherApps: true)

    historyWindowController = HistoryFactory.makeViewController()
    historyWindowController?.window?.makeKeyAndOrderFront(self)
    historyWindowController?.window?.center()
  }

  func closeHistory() {
    historyWindowController?.close()
    historyWindowController = nil
  }

  func showAbout() {
    closeAbout()
    NSApplication.shared.activate(ignoringOtherApps: true)

    aboutWindowController = AboutSectionBuilder().build()
    aboutWindowController?.window?.makeKeyAndOrderFront(self)
    aboutWindowController?.window?.center()
  }

  func closeAbout() {
    aboutWindowController?.close()
    aboutWindowController = nil
  }

  func closeOpenWindows() {
    closeTimeSelector()
    closeHistory()
    closeAbout()
  }

  func activatePreviousApp() {
    let app = NSWorkspace.shared.menuBarOwningApplication
    app?.activate()
  }

  func quitApp() {
    NSApplication.shared.terminate(self)
  }
}
