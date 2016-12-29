//
//  Int+bytes.swift
//  TaskTimer
//
//  Created by Sam Dean on 29/12/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import Foundation


private let kilobytes = Int64(1024)
private let megabytes = Int64(1024 * 1024)


extension Int64 {

    func displayBytes() -> String {
        switch self {

        case 0..<kilobytes:
            return "\(self)b"

        case kilobytes..<megabytes:
            return "\(self/kilobytes)kb"

        default:
            return "\(self/megabytes)mb"
        }
    }
}


extension Int {

    func displayBytes() -> String {
        return Int64(self).displayBytes()
    }
}

extension Int32 {

    func displayBytes() -> String {
        return Int64(self).displayBytes()
    }
}

extension Int16 {

    func displayBytes() -> String {
        return Int64(self).displayBytes()
    }
}

extension UInt {

    func displayBytes() -> String {
        return Int64(self).displayBytes()
    }
}

extension UInt64 {

    func displayBytes() -> String {
        return Int64(self).displayBytes()
    }
}

extension UInt32 {

    func displayBytes() -> String {
        return Int64(self).displayBytes()
    }
}

extension UInt16 {

    func displayBytes() -> String {
        return Int64(self).displayBytes()
    }
}
