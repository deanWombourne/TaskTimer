//
//  TaskTimer.swift
//  TaskTimer
//
//  Created by Sam Dean on 17/12/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import Foundation

import CoreStore

private class BundleIdentifierClass: NSObject { }

public enum TaskTimerError: Error, Liftable {
    case unknown(message: String)
    case underlying(Error)

    case failedToFetch
    case failedToFindEntity(withID: String)

    public static func lift(_ error: Error) -> TaskTimerError {
        return error as? TaskTimerError ?? .underlying(error)
    }
}

public func initialize() { TaskTimer.initialize() }
public func reset() { TaskTimer.reset() }
public var storageURL: URL { return TaskTimer.storage.fileURL }

struct TaskTimer {

    private static let constantIDKey = "TaskTimerModelStoreIdentifier"

    private static func constantID() -> String {
        return UserDefaults.standard.string(forKey: TaskTimer.constantIDKey) ?? {
            let value = UUID().uuidString
            UserDefaults.standard.set(value, forKey: TaskTimer.constantIDKey)
            UserDefaults.standard.synchronize()
            print("Created new store identifier: \(value)")
            return value
        }()
    }

    private static func resetConstantID() {
        UserDefaults.standard.removeObject(forKey: TaskTimer.constantIDKey)
        UserDefaults.standard.synchronize()
    }

    private(set) static var storage: SQLiteStore!

    static func initialize() {
        let modelBundle = Bundle(for: BundleIdentifierClass.self)

        self.storage = SQLiteStore(fileName: "TaskTimer" + TaskTimer.constantID(),
                                   configuration: nil,
                                   mappingModelBundles: [ modelBundle ],
                                   localStorageOptions: .recreateStoreOnModelMismatch)

        CoreStore.defaultStack = DataStack(
            modelName: "TaskTimer",
            bundle: modelBundle
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
