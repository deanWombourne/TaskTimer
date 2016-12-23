//
//  Either.swift
//  TaskTimer
//
//  Created by Sam Dean on 23/12/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import Foundation


enum Either<LeftType, RightType> {
    case left(LeftType)
    case right(RightType)

    var isLeft: Bool {
        switch self {
        case .left: return true
        case .right: return false
        }
    }

    var isRight: Bool {
        return !self.isLeft
    }

    func swap() -> Either<RightType, LeftType> {
        switch self {
        case .left(let value): return .right(value)
        case .right(let value): return .left(value)
        }
    }

    func fold<U>(fl: (LeftType) throws -> U, fr: (RightType) throws -> U) rethrows -> U {
        switch self {
        case .left(let value): return try fl(value)
        case .right(let value): return try fr(value)
        }
    }

    func mapRight<U>(_ transform: (RightType) throws -> U) rethrows -> Either<LeftType, U> {
        switch self {
        case .left(let value): return .left(value)
        case .right(let value): return .right(try transform(value))
        }
    }

    func mapLeft<U>(_ transform: (LeftType) throws -> U) rethrows -> Either<U, RightType> {
        switch self {
        case .left(let value): return .left(try transform(value))
        case .right(let value): return .right(value)
        }
    }

    func map<U>(_ transform: (RightType) throws -> U) rethrows -> Either<LeftType, U> {
        return try self.mapRight(transform)
    }
}
