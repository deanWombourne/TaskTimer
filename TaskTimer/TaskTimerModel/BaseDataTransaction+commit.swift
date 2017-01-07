//
//  BaseDataTransaction+commit.swift
//  TaskTimer
//
//  Created by Sam Dean on 28/12/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import Foundation

import CoreStore

extension AsynchronousDataTransaction {

    func commit<T: EntityMappable>(returning entity: T.EntityType, completion: @escaping Command<T>.CompletionFunction) {
        self.commit { result in
            switch result {

            case .failure(let error):
                completion(.failure(.lift(error)))

            case .success:
                guard let entity = CoreStore.fetchExisting(entity) else {
                    completion(.failure(.unknown(message: "Creation of \(T.self) failed - could not find created entity")))
                    return
                }

                completion(.success(.from(entity: entity)))
            }
        }
    }
}
