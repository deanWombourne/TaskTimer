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
    let entityID: NSManagedObjectID
    let name: String

    var tasks: [Task] {
        guard let tasks = self.entity?.tasks?.allObjects as? [TaskEntity] else {
            return []
        }

        return tasks.map { Task.from(entity: $0) }
    }

    func createTask(withName name: String) -> Command<Task> {
        return Command { completion in
            CoreStore.beginAsynchronous { transaction in

                guard let project = transaction.fetchExisting(self.entityID) as? Project.EntityType else {
                    completion(.failure(.failedToFindEntity(withIdentifier: self.entityID)))
                    return
                }

                let task = transaction.create(Into(Task.EntityType.self))

                task.name = name
                task.updatedAt = NSDate()
                task.project = project

                transaction.commit(returning: task, completion: completion)
            }
        }
    }
}
