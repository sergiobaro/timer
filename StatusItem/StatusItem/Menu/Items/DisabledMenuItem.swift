import AppKit

class DisabledMenuItem: MenuItem {

  private let title: String

  init(title: String) {
    self.title = title
  }

  func build() -> NSMenuItem {
    let item = NSMenuItem(title: title, action: nil, keyEquivalent: "")
    item.isEnabled = false

    return item
  }
}
