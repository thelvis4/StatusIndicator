//
//  StatusIndicator.swift
//  StatusIndicator
//
//  Created by Andrei Raifura on 12/15/15.
//  Copyright © 2015 Andrei Raifura. All rights reserved.
//

import XcodeIDEKit

/**
 Defines a container of statuses.
 */
public protocol StatusContainerType {
    func addStatus(status: Status)
    func removeStatus(status: Status)
}


/**
 Manages the status from Xcode status bar.
 
 To display a status(an instance of `Status`), it has to be configured and added.
 Changes made to status(progress change, data change, completed state) afterwards
 will be reflected immediately in Xcode. There is no need to add another status
 in order to make changes to the displayed one.
 
 To remove a status from status bar, `removeStatus(status)` has to be called.
 */
public struct StatusIndicator: StatusContainerType {
    private let activityController: XKActivityController
    
    /**
     The only initializer. It is going to fail if Xcode's window which displays
     statuses cannot be found.
     */
    public init?() {
        guard let activityController = XKActivityController() else {
            return nil;
        }
        
        self.activityController = activityController
    }
    
    /**
     Adds a status in status list.
     
     If there are no active statuses, the added status will become active.
     
     If there are other active statuses, Xcode will display a badge indicating
     the number of active statuses in status list. There is no certainty which
     staus will become active.
     */
    public func addStatus(status: Status) {
        self.activityController.addReport(status.report)
    }
    
    /**
     Removes a status from status list.
     It is recomended to set the status as completed before removing it.
     ```swift
     status.completed = true
     indicator.removeStatus(status)
     ```
     
     After the status is removed, Xcode will continue to display the last state.
     This is done in order to imitate Xcode's default behaviour, like when a
     build is done.
     */
    public func removeStatus(status: Status) {
        self.activityController.removeReport(status.report)
    }
    
}
