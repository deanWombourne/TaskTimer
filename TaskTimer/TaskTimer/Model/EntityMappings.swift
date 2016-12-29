//
//  EntityMapping.swift
//  TaskTimer
//
//  Created by Sam Dean on 20/12/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import Foundation


extension Client: EntityMappable {
    typealias EntityType = ClientEntity

    static func from(entity: ClientEntity) -> Client {
        return Client(id: entity.id!, name: entity.name!)
    }
}


extension Project: EntityMappable {
    typealias EntityType = ProjectEntity

    static func from(entity: ProjectEntity) -> Project {
        return Project(id: entity.id!, name: entity.name!)
    }
}


extension Task: EntityMappable {
    typealias EntityType = TaskEntity

    static func from(entity: TaskEntity) -> Task {
        return Task(id: entity.id!, name: entity.name!)
    }
}


extension TimeSlice: EntityMappable {
    typealias EntityType = TimeSliceEntity

    static func from(entity: TimeSliceEntity) -> TimeSlice {
        return TimeSlice(id: entity.id!,
                         start: entity.start! as Date,
                         end: entity.end as? Date)
    }
}
