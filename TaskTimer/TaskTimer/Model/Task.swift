//
//  Task.swift
//  TaskTimer
//
//  Created by Sam Dean on 17/12/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import Foundation

import CoreStore

struct Task {
    let name: String

    init(entity: TaskEntity) {
        self.name = entity.name
    }
}
