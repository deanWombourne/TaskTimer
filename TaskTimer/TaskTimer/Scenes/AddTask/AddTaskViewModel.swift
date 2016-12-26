//
//  AddTaskViewModel.swift
//  TaskTimer
//
//  Created by Sam Dean on 26/12/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import Foundation


protocol NameCreatable {

    var name: String { get }

    static func create(withName name: String) throws -> Self

}


enum AddTaskEntry<T: NameCreatable> {
    case existing(T)
    case create(name: String)

    var name: String {
        switch self {
        case .create(let name): return name
        case .existing(let value): return value.name
        }
    }

    func execute() throws -> T {
        switch self {
        case .existing(let value): return value
        case .create(let name): return try T.create(withName: name)
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




extension Client: NameCreatable {

    static func create(withName name: String) throws -> Client {
        return Client(name: name)
    }

}


extension Project: NameCreatable {

    static func create(withName name: String) throws -> Project {
        return Project(name: name)
    }
}
