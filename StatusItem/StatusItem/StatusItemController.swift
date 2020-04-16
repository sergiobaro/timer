import Foundation
import TimeSelector
import History
import Common

public protocol StatusItemController {

  func start()
}

class StatusItemControllerDefault: StatusItemController {

  private let formatter = TimerFormatter()

  private let view: StatusItemView
  private let router: StatusItemRouter
  private let timer: TickTimer
  private let sounds: SoundsService
  private let history: HistoryRepository

  private var currentTask: Task?

  init(
    view: StatusItemView,
    router: StatusItemRouter,
    timer: TickTimer,
    sounds: SoundsService,
    history: HistoryRepository
  ) {
    self.view = view
    self.router = router
    self.timer = timer
    self.sounds = sounds
    self.history = history
  }

  func start() {
    setInitialState()
  }
}

private extension StatusItemControllerDefault {

  func setInitialState() {
    view.title = loc("statusbar.title", self)

    view.menu = MenuBuilder()
      .addStartItems()
      .addSeparator()
      .addHistoryItem()
      .addQuitAppItem()
      .build(delegate: self)
  }

  @objc func startTimer(name: String, finishTimeInterval: TimeInterval) {
    router.closeOpenWindows()

    currentTask = Task(name: name, duration: finishTimeInterval, startedAt: Date(), completed: false)

    view.menu = MenuBuilder()
      .addCurrentTimerItem(with: name)
      .addCancelItem()
      .addSeparator()
      .addHistoryItem()
      .addQuitAppItem()
      .build(delegate: self)

    timer.start { [weak self] timeInterval in
      self?.view.title = self?.formatter.format(timeInterval, from: finishTimeInterval)

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
    if var task = currentTask {
      task.completed = true
      history.save(task: task)
    }
    stopTimer()
    sounds.playFinished()
    router.showFinished()
  }
}

extension StatusItemControllerDefault: TimeSelectorDelegate {

  func timeSelectorDidSelect(name: String, timeInterval: TimeInterval) {
    startTimer(name: name, finishTimeInterval: timeInterval)
  }
}

extension StatusItemControllerDefault: MenuDelegate {

  func menuDidStartTime(_ timeInterval: TimeInterval) {
    startTimer(name: "", finishTimeInterval: timeInterval)
  }

  func menuDidCancelTimer() {
    if let task = currentTask {
      history.save(task: task)
    }
    stopTimer()
  }

  func menuDidSelectHistory() {
    router.showHistory()
  }

  func menuDidSelectTime() {
    router.showTimeSelector(delegate: self)
  }

  func menuDidQuitApp() {
    router.quitApp()
  }
}
