import Cocoa

protocol TimeSelectorDelegate: class {
  
  func timeSelectorDidSelectMinutes(_ minutes: Int)
  func timeSelectorDidClose()
}

class TimeSelectorViewController: NSViewController {
  
  weak var delegate: TimeSelectorDelegate?
  
  @IBOutlet private weak var messageLabel: NSTextField!
  @IBOutlet private weak var minutesTextField: NSTextField!
  @IBOutlet private weak var startButton: NSButton!
  
  override func viewDidAppear() {
    super.viewDidAppear()
    
    view.window?.title = localize("time.selector.title")
    view.window?.delegate = self
    
    messageLabel.stringValue = localize("time.selector.message")
    minutesTextField.placeholderString = localize("time.selector.placeholder")
    minutesTextField.formatter = MinutesFormatter()
    startButton.title = localize("time.selector.start.button")
    startButton.keyEquivalent = "\r"
    
    minutesTextField.becomeFirstResponder()
  }
  
  @IBAction private func tapStartButton(_ sender: NSButton) {
    guard let minutes = Int(minutesTextField.stringValue) else {
      return
    }
    
    view.window?.close()
    delegate?.timeSelectorDidSelectMinutes(minutes)
    delegate?.timeSelectorDidClose()
  }
}

extension TimeSelectorViewController: NSWindowDelegate {
  
  func windowWillClose(_ notification: Notification) {
    delegate?.timeSelectorDidClose()
  }
}

private class MinutesFormatter: NumberFormatter {
  
  let allowedCharacters = CharacterSet(charactersIn: "0123456789")
  let maxLength = 4
  
  override func isPartialStringValid(_ partialString: String, newEditingString newString: AutoreleasingUnsafeMutablePointer<NSString?>?, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
    
    if partialString.count > maxLength {
      return false
    }
    
    return partialString.rangeOfCharacter(from: allowedCharacters.inverted) == nil
  }
}
