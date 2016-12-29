//
//  TaskEntity+CoreDataProperties.swift
//  TaskTimer
//
//  Created by Sam Dean on 23/12/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension TaskEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
        return NSFetchRequest<TaskEntity>(entityName: "TaskEntity");
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var updatedAt: NSDate?
    @NSManaged public var project: ProjectEntity?
    @NSManaged public var timeSlices: NSSet?

}

// MARK: Generated accessors for timeSlices
extension TaskEntity {

    @objc(addTimeSlicesObject:)
    @NSManaged public func addToTimeSlices(_ value: TimeSliceEntity)

    @objc(removeTimeSlicesObject:)
    @NSManaged public func removeFromTimeSlices(_ value: TimeSliceEntity)

    @objc(addTimeSlices:)
    @NSManaged public func addToTimeSlices(_ values: NSSet)

    @objc(removeTimeSlices:)
    @NSManaged public func removeFromTimeSlices(_ values: NSSet)

}
