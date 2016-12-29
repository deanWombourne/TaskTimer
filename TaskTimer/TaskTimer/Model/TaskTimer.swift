//
//  TaskTimer.swift
//  TaskTimer
//
//  Created by Sam Dean on 17/12/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import Foundation

import CoreStore


enum TaskTimerError: Error, Liftable {
    case unknown(message: String)
    case underlying(Error)

    case failedToFetch
    case failedToFindEntity(withID: String)

    static func lift(_ error: Error) -> TaskTimerError {
        return error as? TaskTimerError ?? .underlying(error)
    }
}


struct TaskTimerModel {

    static let storage: SQLiteStore = SQLiteStore(fileName: "TaskTimer", configuration: nil, mappingModelBundles: [Bundle.main], localStorageOptions: .recreateStoreOnModelMismatch)

    static func initialize() {
        CoreStore.defaultStack = DataStack(
            modelName: "TaskTimer"
        )

        try! CoreStore.defaultStack.addStorageAndWait(storage)
    }
}
