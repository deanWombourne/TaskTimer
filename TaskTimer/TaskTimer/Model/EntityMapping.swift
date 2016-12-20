//
//  EntityMapping.swift
//  TaskTimer
//
//  Created by Sam Dean on 20/12/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import Foundation


extension Project {

    init(entity: ProjectEntity) {
        self.name = entity.name
    }
}


extension Client: EntityMappable {
    typealias EntityType = ClientEntity

    static func from(entity: ClientEntity) -> Client {
        return Client(name: entity.name)
    }
}
