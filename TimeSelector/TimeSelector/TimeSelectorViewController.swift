import Cocoa
import Common

class TimeSelectorViewController: NSViewController {

  weak var delegate: TimeSelectorDelegate?

  @IBOutlet private weak var nameTextField: NSTextField!
  @IBOutlet private weak var minutesLabel: NSTextField!
  @IBOutlet private weak var minutesTextField: NSTextField!
  @IBOutlet private weak var minutesStepper: NSStepper!
  @IBOutlet private weak var startButton: NSButton!

  override func viewDidAppear() {
    super.viewDidAppear()

    view.window?.title = loc("time.selector.title", self)

    nameTextField.placeholderString = loc("time.selector.name.placeholder", self)
    minutesLabel.stringValue = loc("time.selector.minutes.label", self)
    minutesTextField.placeholderString = loc("time.selector.minutes.placeholder", self)
    minutesTextField.formatter = MinutesFormatter()
    startButton.title = loc("time.selector.start.button", self)
    startButton.keyEquivalent = "\r"

    minutesStepper.maxValue = 9999
    minutesStepper.target = self
    minutesStepper.action = #selector(minutesStepperDidChange)

    minutesTextField.delegate = self

    nameTextField.becomeFirstResponder()
  }

  @IBAction private func tapStartButton(_ sender: NSButton) {
    guard let minutes = Int(minutesTextField.stringValue),
      minutes > 0
    else {
      return
    }

    view.window?.close()

    let timeInterval = TimeInterval(minutes * 60)
    delegate?.timeSelectorDidSelect(name: nameTextField.stringValue, timeInterval: timeInterval)
  }

  @objc private func minutesStepperDidChange(_ sender: NSStepper) {
    let value = sender.integerValue
    minutesTextField.stringValue = String(value)
  }
}

extension TimeSelectorViewController: NSTextFieldDelegate {

  func controlTextDidChange(_ obj: Notification) {
    guard let integerValue = Int(minutesTextField.stringValue) else { return }
    minutesStepper.integerValue = integerValue
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
