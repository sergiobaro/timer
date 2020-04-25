import Cocoa

class HistoryListSectionBuilder {

  func build() -> NSWindowController? {
    let bundle = Bundle(for: type(of: self))
    let storyboard = NSStoryboard(name: "HistoryList", bundle: bundle)
    guard let windowController = storyboard.instantiateInitialController() as? NSWindowController else {
      return nil
    }

    windowController.window?.minSize = NSSize(width: 500, height: 400)

    if let view = windowController.contentViewController as? HistoryListViewController {
      let repository = HistoryFactory.makeRepository()
      let router = HistoryListRouterDefault(viewController: view)
      let exportInteractor = HistoryExportInteractorDefault(repository: repository)
      let presenter = HistoryListPresenterDefault(
        view: view,
        router: router,
        exportInteractor: exportInteractor,
        repository: repository
      )
      view.presenter = presenter
    }

    return windowController
  }
}
