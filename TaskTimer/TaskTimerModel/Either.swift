//
//  Either.swift
//  TaskTimer
//
//  Created by Sam Dean on 23/12/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import Foundation

public enum Either<LeftType, RightType> {
    case failure(LeftType)
    case success(RightType)

    var isLeft: Bool {
        switch self {
        case .failure: return true
        case .success: return false
        }
    }

    var isRight: Bool {
        return !self.isLeft
    }

    func swap() -> Either<RightType, LeftType> {
        switch self {
        case .failure(let value): return .success(value)
        case .success(let value): return .failure(value)
        }
    }

    func fold<U>(foldLeft: (LeftType) throws -> U, foldRight: (RightType) throws -> U) rethrows -> U {
        switch self {
        case .failure(let value): return try foldLeft(value)
        case .success(let value): return try foldRight(value)
        }
    }

    func mapRight<U>(_ transform: (RightType) throws -> U) rethrows -> Either<LeftType, U> {
        switch self {
        case .failure(let value): return .failure(value)
        case .success(let value): return .success(try transform(value))
        }
    }

    func mapLeft<U>(_ transform: (LeftType) throws -> U) rethrows -> Either<U, RightType> {
        switch self {
        case .failure(let value): return .failure(try transform(value))
        case .success(let value): return .success(value)
        }
    }

    func map<U>(_ transform: (RightType) throws -> U) rethrows -> Either<LeftType, U> {
        return try self.mapRight(transform)
    }
}
