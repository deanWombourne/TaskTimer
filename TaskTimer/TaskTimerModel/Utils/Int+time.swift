//
//  Int+time.swift
//  TaskTimer
//
//  Created by Sam Dean on 22/12/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import Foundation

protocol TimeConvertable {
    var seconds: TimeInterval { get }

    var minutes: TimeInterval { get }

    var hours: TimeInterval { get }

    var days: TimeInterval { get }

    var weeks: TimeInterval { get }
}

extension TimeConvertable {
    var second: TimeInterval { return self.seconds }
    var minute: TimeInterval { return self.minutes }
    var hour: TimeInterval { return self.hours }
    var day: TimeInterval { return self.days }
    var week: TimeInterval { return self.weeks }
}

extension Int: TimeConvertable {

    var seconds: TimeInterval { return TimeInterval(self) }

    var minutes: TimeInterval { return self.second * 60 }

    var hours: TimeInterval { return self.minute * 60 }

    var days: TimeInterval { return self.hour * 24 }

    var weeks: TimeInterval { return self.day * 7 }
}

extension Double: TimeConvertable {
    var seconds: TimeInterval { return self }

    var minutes: TimeInterval { return self.second * 60 }

    var hours: TimeInterval { return self.minute * 60 }

    var days: TimeInterval { return self.hour * 24 }

    var weeks: TimeInterval { return self.day * 7 }
}
