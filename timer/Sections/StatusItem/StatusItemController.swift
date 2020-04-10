import Foundation

class StatusItemController {

  private let formatter = TimerFormatter()
  private let view: StatusItemView
  private let router: StatusItemRouter
  private let timer: TickTimer
  private let sounds: SoundsService
  private let application: ApplicationService

  init(
    view: StatusItemView,
    router: StatusItemRouter,
    timer: TickTimer,
    sounds: SoundsService,
    application: ApplicationService
  ) {
    self.view = view
    self.router = router
    self.timer = timer
    self.sounds = sounds
    self.application = application

    setInitialState()
  }
}

private extension StatusItemController {

  func setInitialState() {
    view.title = localize("statusbar.title")

    view.menuItems = MenuItemsBuilder()
      .add(menuItems: buildDefaultMenuItems())
      .add(ActionMenuItem(title: localize("statusbar.start") + "...", callback: { [weak self] in
        guard let self = self else { return }
        self.router.showTimeSelector(delegate: self)
      }))
      .addSeparator()
      .add(ActionMenuItem(title: localize("statusbar.quit"), callback: { [weak self] in
        self?.application.close()
      }))
      .build()
  }

  @objc func startTimer(finishTimeInterval: TimeInterval) {
    router.hideFinished()

    view.menuItems = MenuItemsBuilder()
      .add(ActionMenuItem(title: localize("statusbar.stop"), callback: { [weak self] in
        self?.stopTimer()
      }))
      .addSeparator()
      .add(ActionMenuItem(title: localize("statusbar.quit"), callback: { [weak self] in
        self?.application.close()
      }))
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
      let title = localize("statusbar.start") + " \(timeString)"
      return ActionMenuItem(title: title) { [weak self] in
        self?.startTimer(finishTimeInterval: timeInterval)
      }
    })
  }
}

extension StatusItemController: TimeSelectorDelegate {

  func timeSelectorDidSelectMinutes(_ minutes: Int) {
    let timeInterval = TimeInterval(minutes * 60)
    self.startTimer(finishTimeInterval: timeInterval)
  }

  func timeSelectorDidClose() {

  }
}
