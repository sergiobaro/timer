import Foundation

protocol TickTimer {
  
  func start(onTick: @escaping (TimeInterval) -> ())
  func stop()
}

class TickTimerDefault: TickTimer {
  
  private var startedAt: Date?
  private var timer: Timer?
  
  func start(onTick: @escaping (TimeInterval) -> ()) {
    stop()
    
    startedAt = Date()
    onTick(0.0)
    
    let timer = Timer(timeInterval: 1.0, repeats: true) { [weak self] _ in
      guard let self = self else { return }
      guard let from = self.startedAt else { return }
      
      let timeInterval = Date().timeIntervalSince(from)
      onTick(timeInterval)
    }
    
    RunLoop.main.add(timer, forMode: .common)
    
    self.timer = timer
  }
  
  func stop() {
    timer?.invalidate()
    timer = nil
    startedAt = nil
  }
}
