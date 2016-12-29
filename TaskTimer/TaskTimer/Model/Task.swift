//
//  Task.swift
//  TaskTimer
//
//  Created by Sam Dean on 17/12/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import Foundation

import CoreStore


struct Task {
    let id: String
    let name: String
}


struct TimeSlice {
    let id: String
    let start: Date
    let end: Date?

    var duration: TimeInterval {
        return -self.start.timeIntervalSince(self.end ?? Date())
    }
}


extension Task {

    static func allActive() -> [Task] {
        return self.all( Where("ANY timeSlices.end = NULL") )
    }

    static func allRecent() -> [Task] {
        let cutoff = Date().addingTimeInterval(1.day)
        return self.all( Where("updatedAt < %@", cutoff), OrderBy(.descending("updatedAt")) )
    }
}
