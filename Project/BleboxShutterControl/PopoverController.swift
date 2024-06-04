//
//  PopoverController.swift
//  BleboxShutterControl
//
//  Created by Kmkamyk on 04/06/2024.
//

import Cocoa
import SwiftUI

class PopoverController: NSObject {
    static let shared = PopoverController()

    private var popover: NSPopover?
    private var statusBarItem: NSStatusItem?

    func setupPopover(_ popover: NSPopover, statusBarItem: NSStatusItem?) {
        self.popover = popover
        self.statusBarItem = statusBarItem
    }

    @objc func togglePopover(_ sender: Any?) {
        if let button = statusBarItem?.button {
            if popover?.isShown == true {
                popover?.performClose(sender)
            } else {
                popover?.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
                popover?.contentViewController?.view.window?.becomeKey()
            }
        }
    }
}
