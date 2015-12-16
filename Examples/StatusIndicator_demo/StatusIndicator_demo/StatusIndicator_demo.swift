//
//  StatusIndicator_demo.swift
//
//  Created by Andrei Raifura on 12/15/15.
//  Copyright © 2015 Andrei Raifura. All rights reserved.
//

import AppKit

var sharedPlugin: StatusIndicator_demo?

class StatusIndicator_demo: NSObject {
    
    var bundle: NSBundle
    lazy var center = NSNotificationCenter.defaultCenter()
    
    init(bundle: NSBundle) {
        self.bundle = bundle
        
        super.init()
        center.addObserver(self, selector: Selector("createMenuItems"), name: NSApplicationDidFinishLaunchingNotification, object: nil)
    }
    
    deinit {
        removeObserver()
    }
    
    func removeObserver() {
        center.removeObserver(self)
    }
    
    func createMenuItems() {
        removeObserver()
        
        let item = NSApp.mainMenu!.itemWithTitle("Edit")
        if item != nil {
            let actionMenuItem = NSMenuItem(title:"Show status", action:"doMenuAction", keyEquivalent:"")
            actionMenuItem.target = self
            item!.submenu!.addItem(NSMenuItem.separatorItem())
            item!.submenu!.addItem(actionMenuItem)
        }
    }
    
    func doMenuAction() {
       TaskRunner().run()
    }
    
}
