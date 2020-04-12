import Foundation
import Common

class MenuBuilder {

  private var items = [MenuItem]()
  private let menu = Menu()

  func addStartItems() -> Self {
    let formatter = TimerFormatter()

    let startDefaultItems: [MenuItem] = Constants.defaultTimeIntervals.map({ timeInterval in
      let timeString = formatter.format(timeInterval)
      let title = loc("statusbar.start", self) + " \(timeString)"
      return ActionMenuItem(title: title) { [weak menu] in
        menu?.delegate?.menuDidStartTime(timeInterval)
      }
    })
    items.append(contentsOf: startDefaultItems)

    let startCustomItem = ActionMenuItem(title: loc("statusbar.start.custom", self)) { [weak menu] in
      menu?.delegate?.menuDidSelectTime()
    }
    items.append(startCustomItem)

    return self
  }

  func addCancelItem() -> Self {
    let stopItem = ActionMenuItem(title: loc("statusbar.cancel", self)) { [weak menu] in
      menu?.delegate?.menuDidCancelTimer()
    }
    items.append(stopItem)

    return self
  }

  func addSeparator() -> Self {
    items.append(SeparatorMenuItem())
    return self
  }

  func addHistoryItem() -> Self {
    let historyItem = ActionMenuItem(title: loc("statusbar.history", self)) { [weak menu] in
      menu?.delegate?.menuDidSelectHistory()
    }
    items.append(historyItem)

    return self
  }

  func addQuitAppItem() -> Self {
    let quitItem = ActionMenuItem(title: loc("statusbar.quit", self)) { [weak menu] in
      menu?.delegate?.menuDidQuitApp()
    }
    items.append(quitItem)

    return self
  }

  func build(delegate: MenuDelegate) -> Menu {
    menu.delegate = delegate
    menu.items = items

    return menu
  }
}
