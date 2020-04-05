import Cocoa

class TimerFinishedViewController: NSViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Timer"
  }
  
  @IBOutlet private weak var doneTextField: NSTextField!
  @IBOutlet private weak var okButton: NSButton!
  
  @IBAction private func tapOkButton(_ sender: NSButton) {
    view.window?.close()
  }
}
