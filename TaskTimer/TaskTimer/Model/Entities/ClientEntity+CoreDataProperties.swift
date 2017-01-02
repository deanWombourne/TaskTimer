//
//  ClientEntity+CoreDataProperties.swift
//  TaskTimer
//
//  Created by Sam Dean on 23/12/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

extension ClientEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ClientEntity> {
        return NSFetchRequest<ClientEntity>(entityName: "ClientEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var projects: NSSet?

}

// MARK: Generated accessors for projects
extension ClientEntity {

    @objc(addProjectsObject:)
    @NSManaged public func addToProjects(_ value: ProjectEntity)

    @objc(removeProjectsObject:)
    @NSManaged public func removeFromProjects(_ value: ProjectEntity)

    @objc(addProjects:)
    @NSManaged public func addToProjects(_ values: NSSet)

    @objc(removeProjects:)
    @NSManaged public func removeFromProjects(_ values: NSSet)

}
