//
//  ShutterBoxApp.swift
//  BleboxShutterControl
//
//  Created by Kmkamyk on 04/06/2024.
//

import SwiftUI

@main
struct ShutterBoxApp: App {
    // Reference to the AppDelegate to handle app lifecycle events
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        Settings {
            EmptyView() // This ensures no window is shown
        }
    }
}
