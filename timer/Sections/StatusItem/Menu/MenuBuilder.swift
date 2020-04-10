import Foundation

class MenuBuilder {

  private var items = [MenuItem]()
  private let menu = Menu()

  func addStartItems() -> Self {
    let formatter = TimerFormatter()

    let startDefaultItems: [MenuItem] = Constants.defaultTimeIntervals.map({ timeInterval in
      let timeString = formatter.format(timeInterval)!
      let title = localize("statusbar.start") + " \(timeString)"
      return ActionMenuItem(title: title) { [weak menu] in
        menu?.delegate?.menuDidStartTime(timeInterval)
      }
    })
    items.append(contentsOf: startDefaultItems)

    let startCustomItem = ActionMenuItem(title: localize("statusbar.start.custom")) { [weak menu] in
      menu?.delegate?.menuDidSelectTime()
    }
    items.append(startCustomItem)

    return self
  }

  func addStopItem() -> Self {
    let stopItem = ActionMenuItem(title: localize("statusbar.stop")) { [weak menu] in
      menu?.delegate?.menuDidStopTimer()
    }
    items.append(stopItem)

    return self
  }

  func addQuitAppItem() -> Self {
    items.append(SeparatorMenuItem())

    let quitItem = ActionMenuItem(title: localize("statusbar.quit")) { [weak menu] in
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
