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
    typealias IDType = NSManagedObjectID

    let id: IDType
    let name: String

    var projects: [Project] {
        guard let projects = self.entity?.projects?.allObjects as? [ProjectEntity] else {
            return []
        }

        return projects.map { Project(entity: $0) }
    }

    static func createClient(withName name: String) -> Command<Client> {
        return Command { completion in

            CoreStore.beginAsynchronous { transaction in
                let client = transaction.create(Into(ClientEntity.self))

                client.name = name

                transaction.commit { result in
                    switch result {

                    case .failure(let error):
                        completion(.failure(.lift(error)))

                    case .success:
                        guard let entity = CoreStore.fetchExisting(client) else {
                            completion(.failure(.unknown(message: "Creation failed")))
                            return
                        }

                        completion(.success(.from(entity: entity)))
                    }
                }
            }
        }
    }

    func createProject(withName name: String) -> Command<Project> {
        return Command { completion in

            CoreStore.beginAsynchronous { transaction in
                guard let client = transaction.fetchExisting(self.id) as? ClientEntity else {
                    completion(.failure(.failedToFindEntity(withIdentifier: self.id)))
                    return
                }

                let project = transaction.create(Into(ProjectEntity.self))

                project.client = client
                project.name = name

                transaction.commit { result in
                    switch result {

                    case .failure(let error):
                        completion(.failure(.lift(error)))

                    case .success:
                        guard let entity = CoreStore.fetchExisting(project) else {
                            completion(.failure(.unknown(message: "Creation failed")))
                            return
                        }

                        completion(.success(.from(entity: entity)))
                    }
                }
            }
        }
    }
}
