import Cocoa

protocol StatusItemView: class {
  
  var title: String? { get set }
  var menuItems: [MenuItem] { get set }
}

class StatusItemViewProxy: StatusItemView {
  
  var title: String? {
    get { statusItem.button?.title }
    set { statusItem.button?.title = newValue ?? "" }
  }
  
  var menuItems: [MenuItem] = [] {
    didSet {
      updateMenuItems()
    }
  }
  
  private let statusItem: NSStatusItem
  
  init(statusItem: NSStatusItem) {
    self.statusItem = statusItem
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
    
    statusItem.menu = menu
  }
  
  @objc private func tapMenuItem(_ sender: NSMenuItem) {
    let index = sender.tag
    let menuItem = menuItems[index]
    menuItem.callback()
  }
}
