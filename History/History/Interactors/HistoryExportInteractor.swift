import Foundation

enum HistoryExportFormat {
  case json
}

protocol HistoryExportInteractor {

  func export(to url: URL, format: HistoryExportFormat) throws
}

class HistoryExportInteractorDefault: HistoryExportInteractor {

  private let repository: HistoryRepository

  init(repository: HistoryRepository) {
    self.repository = repository
  }

  func export(to url: URL, format: HistoryExportFormat) throws {
    let path = url.path
    let tasks = self.repository.allTasks()

    let data = try formatTasks(tasks, to: format)

    let fileManager = FileManager.default
    if fileManager.fileExists(atPath: path) {
      try fileManager.removeItem(atPath: path)
    }

    fileManager.createFile(atPath: path, contents: data, attributes: nil)
  }

  private func formatTasks<T: Encodable>(_ tasks: T, to format: HistoryExportFormat) throws -> Data {
    switch format {
    case .json:
      let encoder = JSONEncoder()
      encoder.outputFormatting = .prettyPrinted
      encoder.dateEncodingStrategy = .iso8601

      return try encoder.encode(tasks)
    }
  }
}
