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

    static func all() -> Result<[Project]> {
        do {
            guard let entities = CoreStore.fetchAll(From(ProjectEntity.self), []) else {
                throw TaskTimerError.failedToFetch
            }

            return .success(entities.map {
                Project(entity: $0)
            })
        } catch let error {
            return .failure(error)
        }
    }

    var tasks: [Task] {
        let entities = CoreStore.fetchAll(From(TaskEntity.self), []) ?? []

        return entities.map {
            Task(entity: $0)
        }
    }
}
