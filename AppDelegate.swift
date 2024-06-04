//
//  AppDelegate.swift
//  BleboxShutterControl
//
//  Created by Kmkamyk on 04/06/2024.
//

import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarItem: NSStatusItem?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Hide dock icon
        NSApp.setActivationPolicy(.accessory)

        // Create the status bar item with variable length
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        if let button = statusBarItem?.button {
            button.image = NSImage(systemSymbolName: "blinds.horizontal.closed", accessibilityDescription: "ShutterBox")
            button.action = #selector(togglePopover(_:))
        }

        // Create the popover
        let popover = NSPopover()
        popover.contentSize = NSSize(width: 400, height: 330)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: ContentView())

        // Setup the popover controller
        PopoverController.shared.setupPopover(popover, statusBarItem: statusBarItem)
    }

    @objc func togglePopover(_ sender: Any?) {
        PopoverController.shared.togglePopover(sender)
    }
}
