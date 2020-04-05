import Cocoa

class StatusItemController {
  
  private var statusItem: NSStatusItem?
  private var timer: Timer?
  private var startedAt: Date?
  private let finishTime: TimeInterval = 5
  
  init() {
    statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    updateTitle()
    updateMenu()
  }
}

private extension StatusItemController {
  
  func updateTitle() {
    if timer == nil {
      statusItem?.button?.title = "Timer"
    } else {
      statusItem?.button?.title = "00:00"
    }
  }
  
  func updateMenu() {
    let statusMenu = NSMenu()
    
    let menuItem: NSMenuItem
    if timer == nil {
      menuItem = NSMenuItem(title: "Start", action: #selector(startTimer), keyEquivalent: "")
    } else {
      menuItem = NSMenuItem(title: "Stop", action: #selector(stopTimer), keyEquivalent: "")
    }
    menuItem.isEnabled = true
    menuItem.target = self
    
    statusMenu.addItem(menuItem)
    
    statusItem?.menu = statusMenu
  }
  
  @objc func startTimer() {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.minute, .second]
    formatter.unitsStyle = .positional
    formatter.zeroFormattingBehavior = .pad

    startedAt = Date()

    timer = Timer(timeInterval: 1.0, repeats: true) { [weak self] _ in
      guard let self = self else { return }
      guard let from = self.startedAt else { return }

      let timeInterval = Date().timeIntervalSince(from)

      self.statusItem?.button?.title = formatter.string(from: timeInterval) ?? ""

      if timeInterval >= self.finishTime {
        self.showFinished()
        self.stopTimer()
      }
    }

    RunLoop.main.add(timer!, forMode: .common)

    updateTitle()
    updateMenu()
  }
  
  @objc func stopTimer() {
    timer?.invalidate()
    timer = nil
    startedAt = nil
    
    updateTitle()
    updateMenu()
  }
  
  func showFinished() {
    guard let button = statusItem?.button else { return }
    
    let vc = TimerFinishedViewController()
    let popover = NSPopover()
    popover.contentViewController = vc
    
    popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
  }
}
