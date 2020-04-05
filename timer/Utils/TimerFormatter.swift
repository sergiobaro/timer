import Foundation

class TimerFormatter {
  
  private let formatter: DateComponentsFormatter = {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.minute, .second]
    formatter.unitsStyle = .positional
    formatter.zeroFormattingBehavior = .pad
    
    return formatter
  }()
  
  func format(_ timeInterval: TimeInterval) -> String? {
    formatter.string(from: timeInterval)
  }
}
