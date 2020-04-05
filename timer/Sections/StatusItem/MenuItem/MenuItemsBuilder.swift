import Foundation

class MenuItemsBuilder {
  
  private var items = [MenuItem]()
  
  func add(menuItem: MenuItem) -> Self {
    items.append(menuItem)
    return self
  }
  
  func add(menuItems: [MenuItem]) -> Self {
    items.append(contentsOf: menuItems)
    return self
  }
  
  func add(title: String, callback: @escaping MenuItem.MenuItemCallback) -> Self {
    return add(menuItem: MenuItem(title: title, callback: callback))
  }
  
  func build() -> [MenuItem] {
    items
  }
}
