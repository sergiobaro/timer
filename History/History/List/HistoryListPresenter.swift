import Common

protocol HistoryListPresenter {

  func viewIsReady()

  func userTapClear()
  func userTapExport()
}

struct HistoryListTask {
  let name: String
  let duration: String
  let completed: String
}

class HistoryListPresenterDefault {

  private weak var view: HistoryListView?
  private let router: HistoryListRouter
  private let exportInteractor: HistoryExportInteractor
  private let repository: HistoryRepository

  private let formatter = TimerFormatter()

  init(
    view: HistoryListView,
    router: HistoryListRouter,
    exportInteractor: HistoryExportInteractor,
    repository: HistoryRepository
  ) {
    self.view = view
    self.router = router
    self.exportInteractor = exportInteractor
    self.repository = repository
  }
}

extension HistoryListPresenterDefault: HistoryListPresenter {

  func viewIsReady() {
    let tasks = repository.allTasks().map {
      HistoryListTask(
        name: $0.name,
        duration: formatter.format($0.duration),
        completed: $0.completed ? "Completed" : "Cancelled"
      )
    }
    view?.showTasks(tasks)
  }

  func userTapClear() {
    repository.removeAll()
    view?.showTasks([])
  }

  func userTapExport() {
    router.showSaveFile { [weak self] url in
      guard let self = self else { return }

      do {
        try self.exportInteractor.export(to: url, format: .json)
      } catch {
        print(error)
      }
    }
  }
}
