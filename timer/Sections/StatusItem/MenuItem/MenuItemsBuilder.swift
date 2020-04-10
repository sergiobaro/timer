import AppKit

protocol MenuItem {

  func build() -> NSMenuItem
}

class MenuItemsBuilder {

  private var items = [MenuItem]()

  func add(_ menuItem: MenuItem) -> Self {
    items.append(menuItem)
    return self
  }

  func add(menuItems: [MenuItem]) -> Self {
    items.append(contentsOf: menuItems)
    return self
  }

  func addSeparator() -> Self {
    items.append(SeparatorMenuItem())
    return self
  }

  func build() -> [MenuItem] {
    items
  }
}
