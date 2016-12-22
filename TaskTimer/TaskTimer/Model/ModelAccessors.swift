//
//  ModelAccessors.swift
//  TaskTimer
//
//  Created by Sam Dean on 20/12/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import Foundation

import CoreStore


protocol EntityMappable {

    associatedtype EntityType: NSManagedObject

    static func all(_ fetchClauses: FetchClause ...) -> [Self]

    static func from(entity: EntityType) -> Self

    var entity: EntityType? { get }
}


extension EntityMappable {

    var entity: EntityType? {
        return CoreStore.fetchOne(From(EntityType.self), [])
    }

    static func all(_ fetchClauses: FetchClause ...) -> [Self] {
        let entities = CoreStore.fetchAll(From(EntityType.self), fetchClauses) ?? []

        return entities.map { self.from(entity: $0) }
    }
}
