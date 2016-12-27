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
    typealias CreateFunction = (_ name: String) -> Command<T>

    case existing(T)
    case create(name: String)

    var name: String {
        switch self {
        case .create(let name): return name
        case .existing(let value): return value.name
        }
    }

    func command(creator: CreateFunction) -> Command<T> {
        switch self {

        case .existing(let value):
            return .succeed(with: value)

        case .create(let name):
            return creator(name)
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
            return Client.createClient(withName: name)
        }
    }

    func createProject() -> AddTaskEntry<Project>.CreateFunction {
        return { name in
            return try self.createProject(withName: name)
        }
    }
}


extension Project: Nameable {
}
