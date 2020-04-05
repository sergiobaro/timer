import Foundation

struct MenuItem {
  
  typealias MenuItemCallback = () -> Void
  
  let title: String
  let callback: MenuItemCallback
}
