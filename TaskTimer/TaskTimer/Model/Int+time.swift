//
//  Int+time.swift
//  TaskTimer
//
//  Created by Sam Dean on 22/12/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import Foundation


extension Int {

    var second: TimeInterval { return TimeInterval(self) }

    var minute: TimeInterval { return self.second * 60 }

    var hour: TimeInterval { return self.minute * 60 }

    var day: TimeInterval { return self.hour * 24 }

    var week: TimeInterval { return self.day * 7 }
}
