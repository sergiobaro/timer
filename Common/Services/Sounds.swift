import AppKit

public protocol SoundsService {

  func playFinished()
}

class SoundsServiceDefault: SoundsService {

  func playFinished() {
    NSSound(named: .init("Glass"))?.play()
  }
}
