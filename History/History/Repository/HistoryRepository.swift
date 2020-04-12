import CoreData

public protocol HistoryRepository {

  func save(task: Task)
  func allTasks() -> [Task]
}

class HistoryRepositoryInMemory: HistoryRepository {

  static let shared = HistoryRepositoryInMemory()

  private init() { }

  private var tasks = [Task]()

  func save(task: Task) {
    tasks.append(task)
  }

  func allTasks() -> [Task] {
    tasks
  }
}

class HistoryRepositoryDefault: HistoryRepository {

  func save(task: Task) {

  }

  func allTasks() -> [Task] {
    []
  }
}
