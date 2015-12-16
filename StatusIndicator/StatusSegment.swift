//
//  StatusSegment.swift
//  StatusIndicator
//
//  Created by Andrei Raifura on 12/16/15.
//  Copyright © 2015 Andrei Raifura. All rights reserved.
//

import XcodeIDEKit


/**
 A component of a composed status.
 */
public enum StatusSegment {
    /**
     Simple text bordered by separators. Separators are optional.
     */
    case Text(String, SegmentSeparators?)
    /**
     A bold text with separators. It has to be used in order to emphasize the
     result of an operation.
     */
    case BoldText(String, SegmentSeparators?)
    /**
     Normal text reporesenting the date and time. It doesn't have separators and
     it's usually used as the last segment in segmented status.
     
     Ex: `Today at 9:41 AM`
     */
    case Date(NSDate)
}

/**
 Separators of a segment. It defines what string will stay in front and afther
 the status segment.
 
 Example:
 ```swift
 let separators = SegmentSeparators(front: " | ", back: ": ")
 let segment = StatusSegment.Text("Build", separators)
 // Result: " | Build: "
 ```
 */
public struct SegmentSeparators {
    public let front: String?
    public let back: String?
    
    public init(front: String?, back: String?) {
        self.front = front
        self.back = back
    }
    
}


public protocol ReportSegmentConvertible {
    func reportSegment() -> XKReportSegment
}

extension StatusSegment: ReportSegmentConvertible {
    
    public func reportSegment() -> XKReportSegment {
        switch self {
        case .Text(let string, let separators):
            return XKReportSegment(string: string, frontSeparator: separators?.front, backSeparator: separators?.back)
        case .BoldText(let string, let separators):
            return XKReportSegment(boldSegmentWithString: string, frontSeparator: separators?.front, backSeparator: separators?.back)
        case .Date(let date):
            return XKReportSegment(date: date)
        }
    }
    
}

