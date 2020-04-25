import Cocoa

public final class HistoryFactory {

  public static func makeRepository() -> HistoryRepository {
    HistoryRepositoryDefault.create(completion: { error in
      if let error = error {
        print(error)
      }
    })
  }

  public static func makeViewController() -> NSWindowController? {
    HistoryListSectionBuilder().build()
  }
}
