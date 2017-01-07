//
//  Task.swift
//  TaskTimer
//
//  Created by Sam Dean on 17/12/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import Foundation

import CoreStore

public struct Task {
    public let id: String
    public let name: String
}

public struct TimeSlice {
    public let id: String
    public let start: Date
    public let end: Date?

    public var duration: TimeInterval {
        return -self.start.timeIntervalSince(self.end ?? Date())
    }
}

public extension Task {

    static func allActive() -> [Task] {
        return self.all( Where("ANY timeSlices.end = NULL") )
    }

    static func allRecent() -> [Task] {
        let cutoff = Date().addingTimeInterval(1.day)
        return self.all( Where("updatedAt < %@", cutoff), OrderBy(.descending("updatedAt")) )
    }
}
