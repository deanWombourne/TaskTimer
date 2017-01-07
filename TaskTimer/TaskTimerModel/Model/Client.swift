//
//  Client.swift
//  TaskTimer
//
//  Created by Sam Dean on 06/12/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import Foundation

import CoreStore

public struct Client {
    public let id: String
    public let name: String

    public static var allClients: [Client] { return self.all() }

    public var projects: [Project] {
        guard let projects = self.entity()?.projects?.allObjects as? [Project.EntityType] else {
            return []
        }

        return projects.map { Project.from(entity: $0) }
    }

    public static func createClient(withName name: String) -> Command<Client> {
        return Command { completion in

            CoreStore.beginAsynchronous { transaction in
                let client = transaction.create(Into(Client.EntityType.self))

                client.id = UUID().uuidString
                client.name = name

                transaction.commit(returning: client, completion: completion)
            }
        }
    }

    public func createProject(withName name: String) -> Command<Project> {
        return Command { completion in

            CoreStore.beginAsynchronous { transaction in
                guard let client = self.entity(from: transaction) else {
                    completion(.failure(.failedToFindEntity(withID: self.id)))
                    return
                }

                let project = transaction.create(Into(Project.EntityType.self))

                project.id = UUID().uuidString
                project.client = client
                project.name = name

                transaction.commit(returning: project, completion: completion)
            }
        }
    }
}
