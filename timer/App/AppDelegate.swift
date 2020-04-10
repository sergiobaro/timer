import Cocoa
import StatusItem

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  var statusItemController: StatusItemController!

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    statusItemController = StatusItemSectionBuilder().build()
    statusItemController.start()
  }
}
