import AppKit

protocol HistoryListRouter {

  func showSaveFile(callback: @escaping (URL) -> Void)
}

class HistoryListRouterDefault: HistoryListRouter {

  private weak var viewController: NSViewController?

  init(viewController: NSViewController) {
    self.viewController = viewController
  }

  func showSaveFile(callback: @escaping (URL) -> Void) {
    guard let window = viewController?.view.window else { return }

    let savePanel = NSSavePanel()
    savePanel.canCreateDirectories = true
    savePanel.showsTagField = false
    savePanel.nameFieldStringValue = "timer.json"

    savePanel.beginSheetModal(for: window) { result in
      guard result == .OK else { return }
      guard let saveUrl = savePanel.url else { return }
      callback(saveUrl)
    }
  }
}
