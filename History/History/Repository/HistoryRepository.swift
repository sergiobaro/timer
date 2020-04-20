import CoreData

enum HistoryRepositoryError: Error {
  case modelNotFound
}

public protocol HistoryRepository {

  func save(task: Task) throws
  func allTasks() -> [Task]
  func removeAll()
}

class HistoryRepositoryDefault {

  static func create(completion: @escaping (Error?) -> Void) -> HistoryRepositoryDefault {
    let repository = HistoryRepositoryDefault()
    repository.load(completion: completion)

    return repository
  }

  private var container: NSPersistentContainer?

  private init() { }

  private func load(completion: @escaping (Error?) -> Void) {
    let bundle = Bundle(for: type(of: self))
    let name = "History"

    guard let modelURL = bundle.url(forResource: name, withExtension: "momd"),
      let mom = NSManagedObjectModel(contentsOf: modelURL)
    else {
      completion(HistoryRepositoryError.modelNotFound)
      return
    }

    container = NSPersistentContainer(name: name, managedObjectModel: mom)
    container?.loadPersistentStores(completionHandler: { (_, error) in
      completion(error)
    })
  }
}

extension HistoryRepositoryDefault: HistoryRepository {

  func save(task: Task) throws {
    guard let context = container?.viewContext else { return }

    mapTaskObject(taskId: UUID().uuidString, task, context: context)

    try context.save()
  }

  func allTasks() -> [Task] {
    guard let context = container?.viewContext else { return [] }

    let request = NSFetchRequest<TaskObject>(entityName: "TaskObject")
    let sort = NSSortDescriptor(key: "startedAt", ascending: false)
    request.sortDescriptors = [sort]

    do {
      return try context.fetch(request).map { mapTask($0) }
    } catch {
      print(error)
      return []
    }
  }

  func removeAll() {
    guard let context = container?.newBackgroundContext() else { return }

    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskObject")
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

    do {
      try context.execute(deleteRequest)
    } catch {
      print(error)
    }
  }
}

private extension HistoryRepositoryDefault {

  func mapTask(_ taskObject: TaskObject) -> Task {
    Task(
      taskId: taskObject.taskId ?? "",
      name: taskObject.name ?? "",
      duration: taskObject.duration,
      startedAt: taskObject.startedAt ?? Date(),
      completed: taskObject.completed
    )
  }

  @discardableResult
  func mapTaskObject(taskId: String, _ task: Task, context: NSManagedObjectContext) -> TaskObject {
    let taskObject = TaskObject(context: context)

    taskObject.taskId = taskId
    taskObject.name = task.name
    taskObject.duration = task.duration
    taskObject.startedAt = task.startedAt
    taskObject.completed = task.completed

    return taskObject
  }
}
