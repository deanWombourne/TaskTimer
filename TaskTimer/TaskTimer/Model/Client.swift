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

    static func initialize() {
        CoreStore.defaultStack = DataStack(
            modelName: "TaskTimer"
        )

        try! CoreStore.defaultStack.addStorageAndWait()
    }
}


struct Project {
    let name: String

    static func all() -> Result<[Project]> {
        do {
            guard let entities = CoreStore.fetchAll(From(ProjectEntity.self), []) else {
                throw TaskTimerError.failedToFetch
            }

            let projects = entities.map { Project(name: $0.name ?? "") }

            return .success(projects)
        } catch let error {
            return .failure(error)
        }
    }
}
