import Cocoa
import Common
import SwiftUI

public class AboutSectionBuilder {

  public init() { }

  public func build() -> NSWindowController {
    let version = VersionStringBuilder().build(bundle: Bundle.main)
    let view = AboutView(title: loc("about.title", self), version: version)
    let viewController = NSHostingController(rootView: view)
    let window = NSWindow(contentViewController: viewController)

    let windowController = WindowController(window: window)
    windowController.window?.styleMask.remove(.resizable)

    return windowController
  }
}
