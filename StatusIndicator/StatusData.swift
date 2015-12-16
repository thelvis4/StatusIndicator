//
//  StatusData.swift
//  StatusIndicator
//
//  Created by Andrei Raifura on 12/16/15.
//  Copyright © 2015 Andrei Raifura. All rights reserved.
//

import XcodeIDEKit

/**
 Holds the data that's going to be shown in a status.
 * Plain represents a simple string.
 ```
 Running Tool...
 ```
 * Segmented defines an array of `ReportSegmentConvertible`. The array is used
 to compose a status which has multiple components.
 
 ```
 Tool name | Operation: Completed | Today at 9:41 AM
 ```
 */
public enum StatusData {
    case Plain(String)
    case Segmented([ReportSegmentConvertible])
    
}

internal protocol XKActivityReportConvertible {
    func toActivityReport() -> XKActivityReport
}

extension StatusData: XKActivityReportConvertible {
    
    func toActivityReport() -> XKActivityReport {
        switch self {
        case .Plain(let string):
            return XKActivityReport(title: string)
        case .Segmented(let segments):
            let reportSegments = segments.map { $0.reportSegment() }
            return XKActivityReport(titleSegments: reportSegments)
        }
    }
    
}

