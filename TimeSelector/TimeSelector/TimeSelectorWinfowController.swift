import AppKit

class TimeSelectorWindowController: NSWindowController {

  override func cancelOperation(_ sender: Any?) {
    close()
  }
}
