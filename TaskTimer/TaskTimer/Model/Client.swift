//
//  Client.swift
//  TaskTimer
//
//  Created by Sam Dean on 06/12/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import Foundation

import CoreStore


enum TaskTimerError: Error {
    case failedToFetch
}


struct Client {
    let name: String

    var projects: [Project] {
        let entities = CoreStore.fetchAll(From(ProjectEntity.self), []) ?? []

        return entities.map { Project(entity: $0) }
    }
}
