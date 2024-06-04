//
//  StatusBarController.swift
//  BleboxShutterControl
//
//  Created by Kmkamyk on 04/06/2024.
//

import Cocoa
import SwiftUI

class StatusBarController {
    private var statusBarItem: NSStatusItem
    private var popover: NSPopover

    init() {
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        popover = NSPopover()
        popover.contentViewController = NSHostingController(rootView: ContentView())

        if let button = statusBarItem.button {
            button.image = NSImage(systemSymbolName: "house.fill", accessibilityDescription: nil)
            button.action = #selector(togglePopover)
            button.target = self
        }
    }

    @objc func togglePopover() {
        if popover.isShown {
            popover.performClose(nil)
        } else {
            if let button = statusBarItem.button {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
                popover.contentViewController?.view.window?.becomeKey()
            }
        }
    }
}
