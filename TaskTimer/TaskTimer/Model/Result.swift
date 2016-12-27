//
//  Result.swift
//  TaskTimer
//
//  Created by Sam Dean on 20/12/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import Foundation


typealias Result<T> = Either<TaskTimerError, T>


struct Command<T> {

    let perform: (_ completion: @escaping (Result<T>) -> ()) -> ()
}


extension Command {

    static func succeed(with value: T) -> Command<T> {
        return Command { completion in
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(10)) {
                completion(.success(value))
            }
        }
    }

    static func fail(with error: Error) -> Command<T> {
        return Command { completion in
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(10)) {
                completion(.failure(.lift(error)))
            }
        }
    }
}



extension Command {

    func map<U>(_ transform: @escaping (T) -> U) -> Command<U> {
        return Command<U> { completion in
            self.perform { result in
                completion(result.map(transform))
            }
        }
    }
}


extension Command {

    func then<U>(_ command: Command<U>) -> Command<U> {
        return Command<U> { completion in
            self.perform { result in
                switch result {

                case .failure(let error):
                    completion(.failure(error))

                case .success:
                    command.perform(completion)
                }
            }
        }
    }
}
