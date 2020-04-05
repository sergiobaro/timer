import Foundation

class StatusItemController {
  
  private let finishTime: TimeInterval = 25 * 60
  private let formatter = TimerFormatter()
  
  private let view: StatusItemView
  private let timer: TickTimer
  private let sounds: SoundsService
  
  init(view: StatusItemView, timer: TickTimer, sounds: SoundsService) {
    self.view = view
    self.timer = timer
    self.sounds = sounds
    
    setInitialState()
  }
}

private extension StatusItemController {
  
  func setInitialState() {
    view.title = localize("title")
    let defaulTime = formatter.format(Constants.defaultTime)!
    updateMenu(menuItem: MenuItem(title: localize("start") + " (\(defaulTime))", block: { [weak self] in
      self?.startTimer()
    }))
  }
  
  func updateMenu(menuItem: MenuItem) {
    view.menuItems = [menuItem]
  }
  
  @objc func startTimer() {
    view.hideFinished()
    
    updateMenu(menuItem: MenuItem(title: localize("stop"), block: { [weak self] in
      self?.stopTimer()
    }))
    
    timer.start { [weak self] timeInterval in
      guard let self = self else { return }
    
      self.view.title = self.formatter.format(timeInterval)

      if timeInterval >= self.finishTime {
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
    view.showFinished()
  }
}
