//
//  Client.swift
//  TaskTimer
//
//  Created by Sam Dean on 06/12/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import Foundation

import CoreStore


struct Client {
    let name: String

    var projects: [Project] {
        guard let projects = self.entity?.projects?.allObjects as? [ProjectEntity] else {
            return []
        }

        return projects.map { Project(entity: $0) }
    }
}
