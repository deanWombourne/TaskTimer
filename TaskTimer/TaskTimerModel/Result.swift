//
//  Result.swift
//  TaskTimer
//
//  Created by Sam Dean on 20/12/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import Foundation

public typealias Result<T> = Either<TaskTimerError, T>

public struct Command<T> {

    public typealias CompletionFunction = (Result<T>) -> Void
    public typealias CommandFunction = (_ completion: @escaping CompletionFunction) -> Void

    public let perform: CommandFunction
}

extension Command {

    public static func succeed(with value: T) -> Command<T> {
        return Command { completion in
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(10)) {
                completion(.success(value))
            }
        }
    }

    public static func fail(with error: Error) -> Command<T> {
        return Command { completion in
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(10)) {
                completion(.failure(.lift(error)))
            }
        }
    }
}

extension Command {

    public func map<U>(_ transform: @escaping (T) -> U) -> Command<U> {
        return Command<U> { completion in
            self.perform { result in
                completion(result.map(transform))
            }
        }
    }
}

extension Command {

    public func then<U>(_ command: Command<U>) -> Command<U> {
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

    public func then<U>(_ function: @escaping (T) -> Command<U>) -> Command<U> {
        return Command<U> { completion in
            self.perform { result in
                switch result {

                case .failure(let error):
                    completion(.failure(error))

                case .success(let value):
                    function(value).perform(completion)
                }
            }
        }
    }
}
