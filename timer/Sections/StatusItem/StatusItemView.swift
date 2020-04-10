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

    menu.items = menuItems.map { $0.build() }

    statusItem.menu = menu
  }
}
