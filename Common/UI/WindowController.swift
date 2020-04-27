import AppKit

public class WindowController: NSWindowController {

  public override init(window: NSWindow?) {
    super.init(window: window)

    setupWindow()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  public override func windowDidLoad() {
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

  public override func cancelOperation(_ sender: Any?) {
    close()
  }
}
