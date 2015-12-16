//
//  TaskRunner.swift
//  StatusIndicator_demo
//
//  Created by Andrei Raifura on 12/16/15.
//  Copyright © 2015 Andrei Raifura. All rights reserved.
//

import StatusIndicator

private let toolName = "Awesome tool"
private let operationDescription = "Checking source code"

struct TaskRunner {
    
    func run() {
        guard let indicator = StatusIndicator() else {
            print("Could not initialize StatusIndicator. Most probably because there is no any Xcode window able to display statuses.")
            return
        }
        
        let status = createStatus()
        indicator.addStatus(status)
        
        loadProgress(status, completion: {
            self.completeStatus(status)
            indicator.removeStatus(status)
        })
    }
    
    func createStatus() -> Status {
        let segments = SegmentGenerator.segmentsForRunningTool(toolName, currentStep: operationDescription)
        let data = StatusData.Segmented(segments)
        return Status(data: data)
    }
    
    func loadProgress(status: Status, completion: Void -> Void) {
        for progress in 0.stride(to: 100, by: 10) {
            dispatchAfter(Double(progress / 20)) {
                status.progress = Float(Float(progress) / Float(100))
            }
        }
        
        dispatchAfter(Double(100 / 20)) {
            status.progress = 1.0
            completion()
        }
    }
    
    func completeStatus(status: Status) {
        let segments = SegmentGenerator.segmentsForSuccesfulOperation(toolName, operationName: operationDescription)
        let successData = StatusData.Segmented(segments)
        status.data = successData
        status.completed = true
    }
    
}

func dispatchAfter(timeInterval: Double, block: Void -> Void) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(timeInterval * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
        block()
    }
}
