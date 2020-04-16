import Foundation

public class TimerFormatter {

  public init() { }

  public func format(_ timeInterval: TimeInterval) -> String {
    let (hours, minutes, seconds) = extract(timeInterval)

    if hours == 0 {
      return format(minutes: minutes, seconds: seconds)
    } else {
      return format(hours: hours, minutes: minutes, seconds: seconds)
    }
  }

  public func format(_ timeInterval: TimeInterval, from totalTimeInterval: TimeInterval) -> String {
    let (totalHours, _, _) = extract(totalTimeInterval)
    let (hours, minutes, seconds) = extract(timeInterval)

    if totalHours == 0 {
      return format(minutes: minutes, seconds: seconds)
    } else {
      return format(hours: hours, minutes: minutes, seconds: seconds)
    }
  }
}

private extension TimerFormatter {
  func format(hours: Int, minutes: Int, seconds: Int) -> String {
    return String(hours) + ":" + stringify(minutes) + ":" + stringify(seconds)
  }

  func format(minutes: Int, seconds: Int) -> String {
    stringify(minutes) + ":" + stringify(seconds)
  }

  func extract(_ timeInterval: TimeInterval) -> (hours: Int, minutes: Int, seconds: Int) {
    let hours = Int(timeInterval / (60 * 60))
    let minutes = (Int(timeInterval) % (60 * 60)) / 60
    let seconds = (Int(timeInterval) % 60)

    return (hours, minutes, seconds)
  }

  func stringify(_ integer: Int) -> String {
    let string = String(integer)
    return String(repeating: "0", count: 2 - string.count) + string
  }
}
