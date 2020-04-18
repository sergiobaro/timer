import Foundation

public class ServicesFactory {

  public static func sounds() -> SoundsService {
    SoundsServiceDefault()
  }

  public static func notifications() -> NotificationsService {
    NotificationsServiceDefault()
  }
}
