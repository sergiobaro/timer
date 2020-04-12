import Foundation

public struct Task {
  public let name: String
  public let duration: TimeInterval
  public let startedAt: Date
  public var completed: Bool

  public init(name: String, duration: TimeInterval, startedAt: Date, completed: Bool) {
    self.name = name
    self.duration = duration
    self.startedAt = startedAt
    self.completed = completed
  }
}
