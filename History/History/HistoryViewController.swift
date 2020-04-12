import Cocoa
import Common

class HistoryViewController: NSViewController {

  struct Columns {
    static let name = NSUserInterfaceItemIdentifier(rawValue: "name")
    static let duration = NSUserInterfaceItemIdentifier(rawValue: "duration")
    static let completed = NSUserInterfaceItemIdentifier(rawValue: "completed")
  }

  @IBOutlet private var tableView: NSTableView!

  private let timeFormatter = TimerFormatter()
  private var tasks = [Task]()

  override func viewDidLoad() {
    super.viewDidLoad()

    self.tasks = HistoryFactory().makeRepository().allTasks()
  }

  override func viewDidAppear() {
    super.viewDidAppear()

    view.window?.title = loc("history.title", self)

    tableView.dataSource = self
    tableView.delegate = self

    tableView.tableColumn(withIdentifier: Columns.name)?.title = loc("history.tasks.column.name", self)
    tableView.tableColumn(withIdentifier: Columns.duration)?.title = loc("history.tasks.column.duration", self)
    tableView.tableColumn(withIdentifier: Columns.completed)?.title = loc("history.tasks.column.completed", self)
  }
}

extension HistoryViewController: NSTableViewDataSource {

  func numberOfRows(in tableView: NSTableView) -> Int {
    tasks.isEmpty ? 1 : tasks.count
  }
}

extension HistoryViewController: NSTableViewDelegate {

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
      cell.textField?.stringValue = timeFormatter.format(task.duration)
    } else if tableColumn?.identifier == Columns.completed {
      cell.textField?.stringValue = String(task.completed)
    }

    return cell
  }
}
