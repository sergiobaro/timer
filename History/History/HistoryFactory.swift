import Cocoa

public final class HistoryFactory {

  static public func makeRepository() -> HistoryRepository {
    HistoryRepositoryDefault.create(completion: { error in
      if let error = error {
        print(error)
      }
    })
  }

  static public func makeViewController() -> NSWindowController? {
    HistoryListSectionBuilder().build()
  }
}
