import AppKit

protocol MenuDelegate: class {

  func menuDidStartTime(_ timeInterval: TimeInterval)
  func menuDidStopTimer()
  func menuDidSelectTime()
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
