//
//  AddTaskViewController.swift
//  TaskTimer
//
//  Created by Sam Dean on 23/12/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import Foundation
import UIKit
import Eureka


final class AddTaskViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        form = Section("Section1")
            <<< PickerInlineRow<String>() {
                $0.title = "ActionSheetRow"
                $0.options = ["One","Two","Three"]
                $0.value = "Two"    // initially selected
            }
            <<< TextRow {
                $0.title = "Client"
                $0.placeholder = "Choose a client"
            }
            <<< PhoneRow {
                $0.title = "Phone Row"
                $0.placeholder = "And numbers here"
            }
            +++ Section("Timings")
            <<< CountDownRow {
                $0.title = "Time taken"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
        }

        form +++ SelectableSection<ListCheckRow<String>>("Where do you live", selectionType: .singleSelection(enableDeselection: true))

        let continents = ["Africa", "Antarctica", "Asia", "Australia", "Europe", "North America", "South America"]
        for option in continents {
            form.last! <<< ListCheckRow<String>(option){ listRow in
                listRow.title = option
                listRow.selectableValue = option
                listRow.value = nil
            }
        }
    }
}
