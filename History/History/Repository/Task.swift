import Foundation

public struct Task: Codable {
  public let taskId: String
  public let name: String
  public let duration: TimeInterval
  public let startedAt: Date
  public var completed: Bool

  public init(taskId: String, name: String, duration: TimeInterval, startedAt: Date, completed: Bool) {
    self.taskId = taskId
    self.name = name
    self.duration = duration
    self.startedAt = startedAt
    self.completed = completed
  }
}
