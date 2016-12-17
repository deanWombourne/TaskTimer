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


enum Result<T> {
    case success(T)
    case failure(Error)
}


struct Client {

    var projects: [Project] {
        let entities = CoreStore.fetchAll(From(ProjectEntity.self), []) ?? []

        return entities.map {
            Project(name: $0.name ?? "")
        }
    }
}
