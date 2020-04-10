import AppKit

class SeparatorMenuItem: MenuItem {
  
  func build() -> NSMenuItem {
    return .separator()
  }
}
