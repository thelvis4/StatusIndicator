//
//  SegmentGenerator.swift
//  StatusIndicator
//
//  Created by Andrei Raifura on 12/16/15.
//  Copyright © 2015 Andrei Raifura. All rights reserved.
//

private let interSegmentsSeparators = SegmentSeparators(front: nil, back: " | ")


/**
 Generates segments for segmented data in common formats.
 */
public struct SegmentGenerator {
    /**
     Returns a segment with no separators representing the current date.
     */
    public static func currentDateSegment() -> ReportSegmentConvertible {
        return StatusSegment.Date(NSDate())
    }
    
    /**
     Returns a bold `Succeeded` segment with a ` | ` separator after it.
     */
    public static func succeededSegment() -> ReportSegmentConvertible {
        return StatusSegment.BoldText("Succeeded", interSegmentsSeparators)
    }
    
    /**
     Returns a bold `Failed` segment with a ` | ` separator after it.
     */
    public static func failedSegment() -> ReportSegmentConvertible {
        return StatusSegment.BoldText("Failed", interSegmentsSeparators)
    }
    
    /**
     Returns an array of segments defining an In-Progress task.
     
     - parameter name: The name of the running tool. Ex: `Taylor`
     - parameter currentStep: The operation currently done. Ex: `Checking...`
     
     - returns: An array of segments defining the format:
     "`Running Taylor | Checking...`"
     */
    public static func segmentsForRunningTool(name: String, currentStep: String) -> [ReportSegmentConvertible]{
        return [
            StatusSegment.Text("Running ", nil),
            StatusSegment.Text(name, interSegmentsSeparators),
            StatusSegment.Text(currentStep, nil)
        ]
    }
    
    /**
     Returns an array of segments defining a successfuly finished operation.
     
     - parameter toolName: The name of the running tool. Ex: `Taylor`
     - parameter operationName: The operation currently done. Ex: `Checking Code`
     
     - returns: An array of segments defining the format:
     "Taylor | Checking Code: **Succeeded** | Today at 9:41 AM"
     */
    public static func segmentsForSuccesfulOperation(toolName: String, operationName: String) -> [ReportSegmentConvertible] {
        return [
            StatusSegment.Text(toolName, interSegmentsSeparators),
            StatusSegment.Text(operationName, SegmentSeparators(front: nil, back: ": ")),
            self.succeededSegment(),
            self.currentDateSegment()
        ]
    }
    
    /**
     Returns an array of segments defining a failing operation.
     
     - parameter toolName: The name of the running tool. Ex: `OCLint`
     - parameter operationName: The operation currently done. Ex: `Checking Code`
     
     - returns: An array of segments defining the format:
     "OCLint | Checking Code: **Failed** | Today at 9:41 AM"
     */
    public static func segmentsForFailedOperation(toolName: String, operationName: String) -> [ReportSegmentConvertible] {
        return [
            StatusSegment.Text(toolName, interSegmentsSeparators),
            StatusSegment.Text(operationName, SegmentSeparators(front: nil, back: ": ")),
            self.failedSegment(),
            self.currentDateSegment()
        ]
    }
}
