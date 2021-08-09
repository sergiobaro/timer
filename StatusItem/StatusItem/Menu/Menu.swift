import AppKit

protocol MenuDelegate: AnyObject {

  func menuDidQuickStart(_ timeInterval: TimeInterval)
  func menuDidCancelTimer()
  func menuDidSelectTime()
  func menuDidSelectAbout()
  func menuDidSelectHistory()
  func menuDidQuitApp()
}

protocol MenuItem {

  func build() -> NSMenuItem
}

class Menu {

  weak var delegate: MenuDelegate?
  var items = [MenuItem]()

  func build() -> NSMenu {
    let menu = NSMenu()
    menu.items = items.map { $0.build() }
    return menu
  }
}
