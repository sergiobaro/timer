import AppKit

protocol ApplicationService {
  
  func close()
}

class ApplicationServiceDefault: ApplicationService {
  
  func close() {
    NSApplication.shared.terminate(nil)
  }
}
