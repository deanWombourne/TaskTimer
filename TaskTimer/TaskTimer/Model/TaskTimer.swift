//
//  TaskTimer.swift
//  TaskTimer
//
//  Created by Sam Dean on 17/12/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import Foundation

import CoreStore


enum TaskTimerError: Error {
    case failedToFetch
    case underlying(Error)

    static func lift(_ error: Error) -> TaskTimerError {
        return error as? TaskTimerError ?? .underlying(error)
    }
}


struct TaskTimer {

    static func initialize() {
        CoreStore.defaultStack = DataStack(
            modelName: "TaskTimer"
        )

        try! CoreStore.defaultStack.addStorageAndWait()
    }
}
