import Cocoa

class TimerFinishedViewController: NSViewController {
  
  @IBOutlet private weak var doneTextField: NSTextField!
  @IBOutlet private weak var okButton: NSButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    doneTextField.stringValue = localize("timer.finished.message")
    okButton.title = localize("timer.finished.ok")
  }
  
  @IBAction private func tapOkButton(_ sender: NSButton) {
    view.window?.close()
  }
}
