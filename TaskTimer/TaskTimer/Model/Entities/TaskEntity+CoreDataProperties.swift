//
//  TaskEntity+CoreDataProperties.swift
//  TaskTimer
//
//  Created by Sam Dean on 18/12/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import Foundation
import CoreData


extension TaskEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
        return NSFetchRequest<TaskEntity>(entityName: "TaskEntity");
    }

    @NSManaged public var name: String?
    @NSManaged public var project: ProjectEntity?

}
