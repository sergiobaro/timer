import Cocoa

class HistoryListSectionBuilder {

  func build() -> NSWindowController? {
    let bundle = Bundle(for: type(of: self))
    let storyboard = NSStoryboard(name: "HistoryList", bundle: bundle)
    guard let windowController = storyboard.instantiateInitialController() as? NSWindowController else {
      return nil
    }

    if let viewController = windowController.contentViewController as? HistoryListViewController {
      windowController.window?.minSize = viewController.view.frame.size

      let repository = HistoryFactory.makeRepository()
      let router = HistoryListRouterDefault(viewController: viewController)
      let exportInteractor = HistoryExportInteractorDefault(repository: repository)
      let presenter = HistoryListPresenterDefault(
        view: viewController,
        router: router,
        exportInteractor: exportInteractor,
        repository: repository
      )
      viewController.presenter = presenter
    }

    return windowController
  }
}
