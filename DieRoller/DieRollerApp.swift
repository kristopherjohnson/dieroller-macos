// DieRollerApp.swift — app entry point

import AppKit
import SwiftUI

@main
struct DieRollerApp: App {
  @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
    .windowResizability(.contentSize)
  }
}

// Quit the app when its single window is closed.
final class AppDelegate: NSObject, NSApplicationDelegate {
  func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    true
  }
}
