import Cocoa
import Common

class TimeSelectorViewController: NSViewController {

  weak var delegate: TimeSelectorDelegate?

  @IBOutlet private weak var messageLabel: NSTextField!
  @IBOutlet private weak var minutesTextField: NSTextField!
  @IBOutlet private weak var startButton: NSButton!

  override func viewDidAppear() {
    super.viewDidAppear()

    view.window?.title = localize("time.selector.title")

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
