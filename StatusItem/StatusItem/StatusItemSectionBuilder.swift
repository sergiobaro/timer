import Cocoa
import Common
import History

public class StatusItemSectionBuilder {

  public init() { }

  public func build() -> StatusItemController {
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    return StatusItemControllerDefault(
      view: StatusItemViewProxy(statusItem: statusItem),
      router: StatusItemRouterDefault(statusItem: statusItem),
      timer: TickTimerDefault(),
      notifications: ServicesFactory.notifications(),
      history: HistoryFactory().makeRepository()
    )
  }
}
