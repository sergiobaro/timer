import AppKit

public protocol SoundsService {

  func playFinished()
}

public class SoundsServiceDefault: SoundsService {

  public init() { }

  public func playFinished() {
    NSSound(named: .init("Glass"))?.play()
  }
}
