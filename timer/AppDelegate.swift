import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  var statusItemController: StatusItemController!
  var timer: Timer?
  
  func applicationDidFinishLaunching(_ aNotification: Notification) {
    statusItemController = StatusItemController()
  }
}
