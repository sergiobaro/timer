import Foundation

class StatusItemController {
  
  private let formatter = TimerFormatter()
  private let view: StatusItemView
  private let router: StatusItemRouter
  private let timer: TickTimer
  private let sounds: SoundsService
  
  init(view: StatusItemView, router: StatusItemRouter, timer: TickTimer, sounds: SoundsService) {
    self.view = view
    self.router = router
    self.timer = timer
    self.sounds = sounds
    
    setInitialState()
  }
}

private extension StatusItemController {
  
  func setInitialState() {
    view.title = localize("title")
    
    view.menuItems = MenuItemsBuilder()
      .add(menuItems: buildDefaultMenuItems())
      .build()
  }
  
  @objc func startTimer(finishTimeInterval: TimeInterval) {
    router.hideFinished()
    
    view.menuItems = MenuItemsBuilder()
      .add(title: localize("stop"), callback: { [weak self] in
        self?.stopTimer()
      })
      .build()
    
    timer.start { [weak self] timeInterval in
      guard let self = self else { return }
    
      self.view.title = self.formatter.format(timeInterval)

      if timeInterval >= finishTimeInterval {
        self.finish()
      }
    }
  }
  
  @objc func stopTimer() {
    timer.stop()
    setInitialState()
  }
  
  func finish() {
    stopTimer()
    sounds.playFinished()
    router.showFinished()
  }
  
  func buildDefaultMenuItems() -> [MenuItem] {
    return Constants.defaultTimeIntervals.map({ timeInterval in
      let timeString = formatter.format(timeInterval)!
      let title = localize("start") + " \(timeString)"
      return MenuItem(title: title) { [weak self] in
        self?.startTimer(finishTimeInterval: timeInterval)
      }
    })
  }
}
