import Cocoa
import Common

protocol HistoryListView: class {

  func showTasks(_ tasks: [HistoryListTask])
}

class HistoryListViewController: NSViewController {

  struct Columns {
    static let name = NSUserInterfaceItemIdentifier(rawValue: "name")
    static let duration = NSUserInterfaceItemIdentifier(rawValue: "duration")
    static let completed = NSUserInterfaceItemIdentifier(rawValue: "completed")
  }

  @IBOutlet private var tableView: NSTableView!
  @IBOutlet private var clearButton: NSButton!

  var presenter: HistoryListPresenter!

  private var tasks = [HistoryListTask]()

  override func viewDidAppear() {
    super.viewDidAppear()

    view.window?.title = loc("history.title", self)

    tableView.dataSource = self
    tableView.delegate = self

    tableView.tableColumn(withIdentifier: Columns.name)?.title = loc("history.tasks.column.name", self)
    tableView.tableColumn(withIdentifier: Columns.duration)?.title = loc("history.tasks.column.duration", self)
    tableView.tableColumn(withIdentifier: Columns.completed)?.title = loc("history.tasks.column.completed", self)

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
}

extension HistoryListViewController: HistoryListView {

  func showTasks(_ tasks: [HistoryListTask]) {
    self.tasks = tasks
    tableView.reloadData()
  }
}

extension HistoryListViewController: NSTableViewDataSource {

  func numberOfRows(in tableView: NSTableView) -> Int {
    tasks.isEmpty ? 1 : tasks.count
  }
}

extension HistoryListViewController: NSTableViewDelegate {

  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
    guard let cell = tableView.makeView(withIdentifier: .init("cell"), owner: self) as? NSTableCellView else {
      return nil
    }

    if tasks.isEmpty {
      if tableColumn?.identifier == Columns.name {
        cell.textField?.stringValue = loc("history.tasks.empty", self)
      } else {
        cell.textField?.stringValue = ""
      }
      return cell
    }

    let task = tasks[row]
    if tableColumn?.identifier == Columns.name {
      cell.textField?.stringValue = task.name
    } else if tableColumn?.identifier == Columns.duration {
      cell.textField?.stringValue = task.duration
    } else if tableColumn?.identifier == Columns.completed {
      cell.textField?.stringValue = task.completed
    }

    return cell
  }
}
