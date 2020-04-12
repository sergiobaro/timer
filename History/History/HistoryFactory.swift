import Cocoa

public final class HistoryFactory {

  public init() { }

  public func makeRepository() -> HistoryRepository {
    HistoryRepositoryInMemory.shared
  }

  public func makeViewController() -> NSWindowController? {
    HistorySectionBuilder().build()
  }
}
