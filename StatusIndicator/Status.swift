//
//  Status.swift
//  StatusIndicator
//
//  Created by Andrei Raifura on 12/16/15.
//  Copyright © 2015 Andrei Raifura. All rights reserved.
//

import XcodeIDEKit

/**
 Defines the state of a status displayed in Xcode's toolbar.
 */
public final class Status {
    internal var report: XKActivityReport
    
    /**
     The `StatusData` defining the displayed text.
     
     Data can be modified during object's lifetime. The changes made will be
     reflected immediately.
     */
    public var data: StatusData {
        didSet {
            report.fillWithData(data)
        }
    }
    
    /**
     The progress of the status. It takes values from 0.0 to 1.0 where 1.0 
     means completed.
     */
    public var progress: Float = 0.0 {
        didSet {
            if self.progress < 0.0 { self.progress = 0.0 }
            if self.progress > 1.0 { self.progress = 1.0 }
            report.progress = CGFloat(self.progress)
        }
    }
    
    /**
     When a status is set as completed, the progress bar is dismissed.
     
     A status should be set as completed before being removed from status list.
     */
    public var completed: Bool = false {
        didSet {
            progress = 1.0
            self.report.completed = true
        }
    }
    
    public init(data: StatusData) {
        self.data = data
        self.report = data.toActivityReport()
    }
    
}

internal extension XKActivityReport {
    
    func fillWithData(data: StatusData) {
        switch data {
        case .Plain(let string):
            guard self.titleSegments.isEmpty else { return } // Once the segments were set, they cannot be removed.
            self.title = string
        case .Segmented(let segments):
            let reportSegments = segments.map { $0.reportSegment() }
            self.titleSegments = reportSegments
        }
    }
    
}
