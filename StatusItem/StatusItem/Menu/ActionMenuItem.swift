import AppKit

class ActionMenuItem: MenuItem {

  typealias Callback = () -> Void

  let title: String
  let callback: Callback

  init(title: String, callback: @escaping Callback) {
    self.title = title
    self.callback = callback
  }

  @objc private func tapMenuItem() {
    callback()
  }

  func build() -> NSMenuItem {
    let item = NSMenuItem(title: title, action: #selector(tapMenuItem), keyEquivalent: "")
    item.target = self

    return item
  }
}
