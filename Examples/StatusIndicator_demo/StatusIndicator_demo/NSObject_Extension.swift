//
//  NSObject_Extension.swift
//
//  Created by Andrei Raifura on 12/15/15.
//  Copyright © 2015 Andrei Raifura. All rights reserved.
//

import Foundation

extension NSObject {
    class func pluginDidLoad(bundle: NSBundle) {
        let appName = NSBundle.mainBundle().infoDictionary?["CFBundleName"] as? NSString
        if appName == "Xcode" {
        	if sharedPlugin == nil {
        		sharedPlugin = StatusIndicator_demo(bundle: bundle)
        	}
        }
    }
}