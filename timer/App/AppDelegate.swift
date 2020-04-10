import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  var statusItemController: StatusItemController!

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    self.statusItemController = StatusItemSectionBuilder().build()
  }
}
