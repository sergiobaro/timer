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
  private let notifications: NotificationsService
  private let history: HistoryRepository

  private var currentTask: Task?

  init(
    view: StatusItemView,
    router: StatusItemRouter,
    timer: TickTimer,
    notifications: NotificationsService,
    history: HistoryRepository
  ) {
    self.view = view
    self.router = router
    self.timer = timer
    self.notifications = notifications
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
      .addCustomStartItem()
      .addSeparator()
      .addQuickStartItems()
      .addSeparator()
      .addHistoryItem()
      .addAboutItem()
      .addQuitAppItem()
      .build(delegate: self)
  }

  @objc func startTimer(name: String, endTimeInterval: TimeInterval) {
    router.activatePreviousApp()
    router.closeOpenWindows()

    currentTask = Task(taskId: "", name: name, duration: endTimeInterval, startedAt: Date(), completed: false)

    view.menu = MenuBuilder()
      .addCurrentTimerItem(with: name)
      .addCancelItem()
      .addSeparator()
      .addHistoryItem()
      .addQuitAppItem()
      .build(delegate: self)

    timer.start { [weak self] timeInterval in
      self?.view.title = self?.formatter.format(timeInterval, from: endTimeInterval)

      if timeInterval >= endTimeInterval {
        self?.timerDidFinish()
      }
    }
  }

  @objc func stopTimer() {
    timer.stop()
    setInitialState()
  }

  func timerDidFinish() {
    if var task = currentTask {
      task.completed = true
      completeTask(task)
    }
    stopTimer()
  }

  func completeTask(_ task: Task) {
    try? history.save(task: task)

    let message = loc("task.default.name", self) + " \"\(task.name)\" " + loc("statusbar.task.completed", self)
    notifications.show(message: message)
  }

  func generateTaskName(timeInterval: TimeInterval) -> String {
    loc("task.default.name", self) + " " + formatter.format(timeInterval)
  }
}

extension StatusItemControllerDefault: TimeSelectorDelegate {

  func timeSelectorDidSelect(name: String, timeInterval: TimeInterval) {
    var name = name
    if name.isEmpty {
      name = generateTaskName(timeInterval: timeInterval)
    }
    startTimer(name: name, endTimeInterval: timeInterval)
  }
}

extension StatusItemControllerDefault: MenuDelegate {

  func menuDidQuickStart(_ timeInterval: TimeInterval) {
    let name = generateTaskName(timeInterval: timeInterval)
    startTimer(name: name, endTimeInterval: timeInterval)
  }

  func menuDidCancelTimer() {
    if let task = currentTask {
      try? history.save(task: task)
    }
    stopTimer()
  }

  func menuDidSelectHistory() {
    router.showHistory()
  }

  func menuDidSelectAbout() {
    router.showAbout()
  }

  func menuDidSelectTime() {
    router.showTimeSelector(delegate: self)
  }

  func menuDidQuitApp() {
    router.quitApp()
  }
}
