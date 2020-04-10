import Cocoa
import Common

class TimeSelectorViewController: NSViewController {

  weak var delegate: TimeSelectorDelegate?

  @IBOutlet private weak var messageLabel: NSTextField!
  @IBOutlet private weak var minutesTextField: NSTextField!
  @IBOutlet private weak var startButton: NSButton!

  override func viewDidAppear() {
    super.viewDidAppear()

    view.window?.title = loc("time.selector.title", self)

    messageLabel.stringValue = loc("time.selector.message", self)
    minutesTextField.placeholderString = loc("time.selector.placeholder", self)
    minutesTextField.formatter = MinutesFormatter()
    startButton.title = loc("time.selector.start.button", self)
    startButton.keyEquivalent = "\r"

    minutesTextField.becomeFirstResponder()
  }

  @IBAction private func tapStartButton(_ sender: NSButton) {
    guard let minutes = Int(minutesTextField.stringValue) else {
      return
    }

    view.window?.close()

    let timeInterval = TimeInterval(minutes * 60)
    delegate?.timeSelectorDidSelectTime(timeInterval)
  }
}

private class MinutesFormatter: NumberFormatter {

  let allowedCharacters = CharacterSet(charactersIn: "0123456789")
  let maxLength = 4

  // swiftlint:disable:next line_length
  override func isPartialStringValid(_ partialString: String, newEditingString newString: AutoreleasingUnsafeMutablePointer<NSString?>?, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {

    if partialString.count > maxLength {
      return false
    }

    return partialString.rangeOfCharacter(from: allowedCharacters.inverted) == nil
  }
}
