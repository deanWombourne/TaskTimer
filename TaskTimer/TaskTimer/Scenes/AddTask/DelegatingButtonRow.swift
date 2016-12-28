//
//  AddTaskButtonRow.swift
//  TaskTimer
//
//  Created by Sam Dean on 26/12/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import Foundation

import Eureka


final class DelegatingButtonRow: _ButtonRowOf<String>, RowType {

    fileprivate var onSelectionCallback: ((DelegatingButtonRow) -> ())?

    func onSelection(callback: ((DelegatingButtonRow) -> ())?) {
        self.onSelectionCallback = callback
    }

    open override func customDidSelect() {
        guard !self.isDisabled else {
            return
        }

        self.onSelectionCallback?(self)
    }
}
