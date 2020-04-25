import Cocoa
import Common

protocol HistoryListView: class {

  func showTasks(_ tasks: [HistoryListTask])
}

class HistoryListViewController: NSViewController {

  @IBOutlet private var tableView: NSTableView!
  @IBOutlet private var exportButton: NSButton!
  @IBOutlet private var clearButton: NSButton!

  var presenter: HistoryListPresenter!

  private var tasks = [HistoryListTask]()

  override func viewDidAppear() {
    super.viewDidAppear()

    view.window?.title = loc("history.title", self)

    tableView.dataSource = self
    tableView.delegate = self

    exportButton.title = loc("history.export.button", self)
    exportButton.action = #selector(tapExportButton)
    exportButton.target = self

    clearButton.title = loc("history.clear.button", self)
    clearButton.action = #selector(tapClearButton)
    clearButton.target = self

    presenter.viewIsReady()
  }
}

private extension HistoryListViewController {

  @objc func tapClearButton() {
    presenter.userTapClear()
  }

  @objc func tapExportButton() {
    presenter.userTapExport()
  }
}

extension HistoryListViewController: HistoryListView {

  func showTasks(_ tasks: [HistoryListTask]) {
    self.tasks = tasks
    tableView.reloadData()
  }
}

extension HistoryListViewController: NSTableViewDataSource {

  func numberOfRows(in tableView: NSTableView) -> Int {
    tasks.count
  }
}

extension HistoryListViewController: NSTableViewDelegate {

  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
    let cell = tableView.makeView(HistoryListTaskCellView.self)

    let task = tasks[row]
    cell?.nameLabel.stringValue = task.name
    cell?.durationLabel.stringValue = task.duration
    cell?.completedLabel.stringValue = task.completed

    return cell
  }

  func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
    false
  }
}

private extension NSTableView {

  func makeView<T: NSTableCellView>(_ type: T.Type) -> T? {
    let identifier = NSUserInterfaceItemIdentifier(String(describing: type))
    return makeView(withIdentifier: identifier, owner: nil) as? T
  }
}
