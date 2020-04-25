import AppKit

class WindowController: NSWindowController {

  override func windowDidLoad() {
    super.windowDidLoad()

    setupWindow()
  }

  func setupWindow() {
    window?.styleMask.insert(.unifiedTitleAndToolbar)
    window?.styleMask.insert(.fullSizeContentView)
    window?.styleMask.insert(.titled)

    window?.toolbar?.isVisible = false
    window?.titleVisibility = .hidden
    window?.titlebarAppearsTransparent = true

    window?.styleMask.remove(.fullScreen)
    window?.styleMask.remove(.miniaturizable)
  }

  override func cancelOperation(_ sender: Any?) {
    close()
  }
}
