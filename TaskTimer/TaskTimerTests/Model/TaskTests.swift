//
//  TaskTests.swift
//  TaskTimer
//
//  Created by Sam Dean on 22/12/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import XCTest
import CoreData

@testable import TaskTimer


class TaskTests: XCTestCase {
    
    func testTimeSlice_WithEndDate_ShouldCalculateDuration() {
        let start = Date().addingTimeInterval(-60)
        let end = start.addingTimeInterval(30)

        let slice = TimeSlice(entityID: NSManagedObjectID(), start: start, end: end)

        XCTAssertEqual(slice.duration, 30)
    }
}
