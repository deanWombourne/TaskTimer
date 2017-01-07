//
//  TimeSliceEntity+CoreDataProperties.swift
//  TaskTimer
//
//  Created by Sam Dean on 23/12/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

extension TimeSliceEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TimeSliceEntity> {
        return NSFetchRequest<TimeSliceEntity>(entityName: "TimeSliceEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var end: NSDate?
    @NSManaged public var start: NSDate?
    @NSManaged public var task: TaskEntity?

}
