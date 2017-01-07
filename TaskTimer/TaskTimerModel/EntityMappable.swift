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

    var id: String { get }

    func entity(from stack: DataStack) -> EntityType?
    func entity(from transaction: BaseDataTransaction) -> EntityType?
}

extension EntityMappable {

    func entity(from stack: DataStack = CoreStore.defaultStack) -> EntityType? {
        return stack.fetchOne(From(EntityType.self), [ Where("id = %@", self.id) ])
    }

    func entity(from transaction: BaseDataTransaction) -> EntityType? {
        return transaction.fetchOne(From(EntityType.self), [ Where("id = %@", self.id) ])
    }

    static func all(_ fetchClauses: FetchClause ...) -> [Self] {
        let entities = CoreStore.fetchAll(From(EntityType.self), fetchClauses) ?? []

        return entities.map { self.from(entity: $0) }
    }
}
