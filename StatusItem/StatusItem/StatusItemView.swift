import Cocoa

protocol StatusItemView: AnyObject {

  var title: String? { get set }
  var menu: Menu? { get set }
}

class StatusItemViewProxy: StatusItemView {

  var title: String? {
    get { statusItem.button?.title }
    set { statusItem.button?.title = newValue ?? "" }
  }

  var menu: Menu? {
    didSet {
      statusItem.menu = menu?.build()
    }
  }

  private let statusItem: NSStatusItem

  init(statusItem: NSStatusItem) {
    self.statusItem = statusItem
  }
}
