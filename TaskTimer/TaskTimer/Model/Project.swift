//
//  Project.swift
//  TaskTimer
//
//  Created by Sam Dean on 17/12/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import Foundation

import CoreStore

struct Project {
    let name: String

    var tasks: [Task] {
        guard let tasks = self.entity?.tasks?.allObjects as? [TaskEntity] else {
            return []
        }

        return tasks.map { Task.from(entity: $0) }
    }
}
