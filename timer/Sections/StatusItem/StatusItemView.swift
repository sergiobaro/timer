import Cocoa

struct MenuItem {
  let title: String
  let block: () -> Void
}

protocol StatusItemView: class {
  
  var title: String? { get set }
  var menuItems: [MenuItem] { get set }
  
  func showFinished()
  func hideFinished()
}

class StatusItemViewProxy: StatusItemView {
  
  var title: String? {
    get { statusItem?.button?.title }
    set { statusItem?.button?.title = newValue ?? "" }
  }
  
  var menuItems: [MenuItem] = [] {
    didSet {
      updateMenuItems()
    }
  }
  
  private var statusItem: NSStatusItem?
  private var timerFinishedPopover: NSPopover?
  
  init() {
    statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
  }
  
  func showFinished() {
    guard let button = statusItem?.button else { return }
    
    let vc = TimerFinishedViewController()
    let popover = NSPopover()
    popover.contentViewController = vc
    popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
    
    self.timerFinishedPopover = popover
  }
  
  func hideFinished() {
    self.timerFinishedPopover?.close()
    self.timerFinishedPopover = nil
  }
}

private extension StatusItemViewProxy {
  
  func updateMenuItems() {
    let menu = NSMenu()
    
    menu.items = menuItems.enumerated().map { index, menuItem in
      let item = NSMenuItem(title: menuItem.title, action: #selector(tapMenuItem), keyEquivalent: "")
      item.target = self
      item.tag = index
      return item
    }
    
    statusItem?.menu = menu
  }
  
  @objc private func tapMenuItem(_ sender: NSMenuItem) {
    let index = sender.tag
    let menuItem = menuItems[index]
    menuItem.block()
  }
}
