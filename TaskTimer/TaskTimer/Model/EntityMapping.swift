//
//  EntityMapping.swift
//  TaskTimer
//
//  Created by Sam Dean on 20/12/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import Foundation


extension Project {

    init(entity: ProjectEntity) {
        self.name = entity.name!
    }
}


extension Client: EntityMappable {
    typealias EntityType = ClientEntity

    static func from(entity: ClientEntity) -> Client {
        return Client(name: entity.name!)
    }
}


extension Project: EntityMappable {
    typealias EntityType = ProjectEntity

    static func from(entity: ProjectEntity) -> Project {
        return Project(name: entity.name!)
    }
}


extension Task: EntityMappable {
    typealias EntityType = TaskEntity

    static func from(entity: TaskEntity) -> Task {
        return Task(name: entity.name!)
    }
}
