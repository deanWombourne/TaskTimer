//
//  Either+liftable.swift
//  TaskTimer
//
//  Created by Sam Dean on 23/12/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import Foundation

public protocol Liftable: Error {
    static func lift(_ error: Error) -> Self
}

extension Either where LeftType: Liftable {

    public func flatMap<U>(_ transform: (RightType) throws -> U) rethrows -> Either<LeftType, U> {
        do {
            return try self.map(transform)
        } catch let error {
            return .failure(.lift(error))
        }
    }
}
