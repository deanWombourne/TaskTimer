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

    private static let constantIDKey = "TaskTimerModelStoreIdentifier"

    private static func constantID() -> String {
        return UserDefaults.standard.string(forKey: TaskTimerModel.constantIDKey) ?? {
            let value = UUID().uuidString
            UserDefaults.standard.set(value, forKey: TaskTimerModel.constantIDKey)
            UserDefaults.standard.synchronize()
            print("Created new store identifier: \(value)")
            return value
        }()
    }

    private static func resetConstantID() {
        UserDefaults.standard.removeObject(forKey: TaskTimerModel.constantIDKey)
        UserDefaults.standard.synchronize()
    }

    static private(set) var storage: SQLiteStore!

    static func initialize() {
        self.storage = SQLiteStore(fileName: "TaskTimer" + TaskTimerModel.constantID(),
                                   configuration: nil,
                                   mappingModelBundles: [Bundle.main],
                                   localStorageOptions: .recreateStoreOnModelMismatch)

        CoreStore.defaultStack = DataStack(
            modelName: "TaskTimer"
        )

        try! CoreStore.defaultStack.addStorageAndWait(self.storage)
    }

    static func reset() {
        let file = self.storage.fileURL

        self.resetConstantID()
        self.initialize()

        try! FileManager.default.removeItem(at: file)
    }
}
