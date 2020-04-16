import Cocoa

public final class HistoryFactory {

  public init() { }

  public func makeRepository() -> HistoryRepository {
    HistoryRepositoryDefault.create()
  }

  public func makeViewController() -> NSWindowController? {
    HistorySectionBuilder().build()
  }
}
