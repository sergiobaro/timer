import Common

protocol HistoryListPresenter {

  func viewIsReady()

  func userTapClear()
}

struct HistoryListTask {
  let name: String
  let duration: String
  let completed: String
}

class HistoryListPresenterDefault {

  private weak var view: HistoryListView?
  private let repository: HistoryRepository

  private let formatter = TimerFormatter()

  init(view: HistoryListView, repository: HistoryRepository) {
    self.view = view
    self.repository = repository
  }
}

extension HistoryListPresenterDefault: HistoryListPresenter {

  func viewIsReady() {
    let tasks = repository.allTasks().map {
      HistoryListTask(
        name: $0.name,
        duration: formatter.format($0.duration),
        completed: $0.completed ? "Yes" : "No"
      )
    }
    view?.showTasks(tasks)
  }

  func userTapClear() {
    repository.removeAll()
    view?.showTasks([])
  }
}
