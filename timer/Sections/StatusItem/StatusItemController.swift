import Foundation

class StatusItemController {

  private let formatter = TimerFormatter()

  private let view: StatusItemView
  private let router: StatusItemRouter
  private let timer: TickTimer
  private let sounds: SoundsService

  init(
    view: StatusItemView,
    router: StatusItemRouter,
    timer: TickTimer,
    sounds: SoundsService
  ) {
    self.view = view
    self.router = router
    self.timer = timer
    self.sounds = sounds

    setInitialState()
  }
}

private extension StatusItemController {

  func setInitialState() {
    view.title = localize("statusbar.title")

    view.menu = MenuBuilder()
      .addStartItems()
      .addQuitAppItem()
      .build(delegate: self)
  }

  @objc func startTimer(finishTimeInterval: TimeInterval) {
    router.closeOpenWindows()

    view.menu = MenuBuilder()
      .addStopItem()
      .addQuitAppItem()
      .build(delegate: self)

    timer.start { [weak self] timeInterval in
      self?.view.title = self?.formatter.format(timeInterval)

      if timeInterval >= finishTimeInterval {
        self?.finish()
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
}

extension StatusItemController: TimeSelectorDelegate {

  func timeSelectorDidSelectTime(_ timeInterval: TimeInterval) {
    startTimer(finishTimeInterval: timeInterval)
  }
}

extension StatusItemController: MenuDelegate {

  func menuDidStartTime(_ timeInterval: TimeInterval) {
    startTimer(finishTimeInterval: timeInterval)
  }

  func menuDidStopTimer() {
    stopTimer()
  }

  func menuDidSelectTime() {
    router.showTimeSelector(delegate: self)
  }

  func menuDidQuitApp() {
    router.quitApp()
  }
}
