import Cocoa

class StatusItemSectionBuilder {
  
  func build() -> StatusItemController {
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    return StatusItemController(
      view: StatusItemViewProxy(statusItem: statusItem),
      router: StatusItemRouterDefault(statusItem: statusItem),
      timer: TickTimerDefault(),
      sounds: SoundsServiceDefault(),
      application: ApplicationServiceDefault()
    )
  }
}
