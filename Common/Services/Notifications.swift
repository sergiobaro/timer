import Foundation

public protocol NotificationsService {

  func show(message: String)
}

class NotificationsServiceDefault: NotificationsService {

  func show(message: String) {
    let notification = NSUserNotification()

    notification.title = loc("notifications.title", self)
    notification.subtitle = message
    notification.soundName = NSUserNotificationDefaultSoundName

    NSUserNotificationCenter.default.deliver(notification)
  }
}
