import Cocoa
import Common
import SwiftUI

public class AboutSectionBuilder {

  public init() { }

  public func build() -> NSWindowController {
    let version = buildVersion()
    let view = AboutView(title: loc("about.title", self), version: version)
    let viewController = NSHostingController(rootView: view)
    let window = NSWindow(contentViewController: viewController)

    let windowController = WindowController(window: window)
    windowController.window?.styleMask.remove(.resizable)

    return windowController
  }

  private func buildVersion() -> String {
    let versionFormat = loc("about.version.format", self)
    return String(format: versionFormat, buildVersionString())
  }

  private func buildVersionString() -> String {
    guard let appVersion = Bundle.main.version else {
      return ""
    }
    guard let buildNumber = Bundle.main.buildNumber else {
      return appVersion
    }

    return "\(appVersion) (\(buildNumber))"
  }
}
