import Cocoa
import Common
import SwiftUI

public class AboutSectionBuilder {

  public init() { }

  public func build() -> NSWindowController {
    let view = AboutView()
    let viewController = NSHostingController(rootView: view)
    let window = NSWindow(contentViewController: viewController)

    let windowController = WindowController(window: window)
    windowController.window?.styleMask.remove(.resizable)

    return windowController
  }
}
