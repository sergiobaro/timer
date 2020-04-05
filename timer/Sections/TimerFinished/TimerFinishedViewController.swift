import Cocoa

class TimerFinishedViewController: NSViewController {
  
  @IBOutlet private weak var doneTextField: NSTextField!
  @IBOutlet private weak var okButton: NSButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    doneTextField.stringValue = localize("finished")
    okButton.title = localize("ok")
  }
  
  @IBAction private func tapOkButton(_ sender: NSButton) {
    view.window?.close()
  }
}
