//
//  AddTaskViewModel.swift
//  TaskTimer
//
//  Created by Sam Dean on 26/12/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import Foundation


protocol Nameable {

    var name: String { get }
}


enum AddTaskEntry<T: Nameable> {
    typealias CreateFunction = (_ name: String) throws -> T

    case existing(T)
    case create(name: String)

    var name: String {
        switch self {
        case .create(let name): return name
        case .existing(let value): return value.name
        }
    }

    func execute(creator: CreateFunction) rethrows -> T {
        switch self {
        case .existing(let value): return value
        case .create(let name): return try creator(name)
        }
    }
}


extension AddTaskEntry: Equatable {
    static func == (lhs: AddTaskEntry, rhs: AddTaskEntry) -> Bool {
        switch (lhs, rhs) {
        case (.create(let lname), .create(let rname)) where lname == rname: return true
        case (.existing(let lclient), .existing(let rclient)) where lclient.name == rclient.name: return true
        default: return false
        }
    }
}


extension AddTaskEntry: CustomStringConvertible {

    var description: String { return self.name }
}




extension Client: Nameable {

    static func create() -> AddTaskEntry<Client>.CreateFunction {
        return { name in
            Client(name: name)
        }
    }

    func createProject() -> AddTaskEntry<Project>.CreateFunction {
        return { name in
            let project = Project(name: name)
            return project
        }
    }
}

extension Project: Nameable { }
