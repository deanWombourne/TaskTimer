//
//  Result.swift
//  TaskTimer
//
//  Created by Sam Dean on 20/12/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(TaskTimerError)

    func map<U>(_ transform: (T) throws -> U) rethrows -> Result<U> {
        switch self {
        case .failure(let error): return .failure(error)
        case .success(let value): return .success(try transform(value))
        }
    }

    func flatMap<U>(_ transform: (T) throws -> U) -> Result<U> {
        do {
            return try self.map(transform)
        } catch let error {
            return .failure(.lift(error))
        }
    }
}
