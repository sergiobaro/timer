import CoreData

public protocol HistoryRepository {

  func save(task: Task)
  func allTasks() -> [Task]
}

class HistoryRepositoryDefault: HistoryRepository {

  static func create() -> HistoryRepositoryDefault {
    let repository = HistoryRepositoryDefault()
    repository.load()

    return repository
  }

  private var container: NSPersistentContainer?

  private init() { }

  private func load() {
    container = NSPersistentContainer(name: "History", bundle: Bundle(for: type(of: self)))
    container?.loadPersistentStores { _, error in
      if let error = error {
        fatalError("Unable to load persistent stores: \(error)")
      }
    }
  }

  func save(task: Task) {
    guard let context = container?.viewContext else { return }

    mapTaskObject(task, context: context)

    do {
      try context.save()
    } catch {
      return
    }
  }

  func allTasks() -> [Task] {
    guard let context = container?.viewContext else { return [] }

    let request = NSFetchRequest<TaskObject>(entityName: "TaskObject")
    let sort = NSSortDescriptor(key: "startedAt", ascending: false)
    request.sortDescriptors = [sort]

    do {
      return try context.fetch(request).map { mapTask($0) }
    } catch {
      return []
    }
  }

  private func mapTask(_ taskObject: TaskObject) -> Task {
    Task(
      name: taskObject.name ?? "",
      duration: taskObject.duration,
      startedAt: taskObject.startedAt ?? Date(),
      completed: taskObject.completed
    )
  }

  @discardableResult
  private func mapTaskObject(_ task: Task, context: NSManagedObjectContext) -> TaskObject {
    let taskObject = TaskObject(context: context)

    taskObject.name = task.name
    taskObject.duration = task.duration
    taskObject.startedAt = task.startedAt
    taskObject.completed = task.completed

    return taskObject
  }
}

extension NSPersistentContainer {

  public convenience init(name: String, bundle: Bundle) {
    guard let modelURL = bundle.url(forResource: name, withExtension: "momd"),
      let mom = NSManagedObjectModel(contentsOf: modelURL)
    else {
        fatalError("Unable to located Core Data model")
    }

    self.init(name: name, managedObjectModel: mom)
  }

}
