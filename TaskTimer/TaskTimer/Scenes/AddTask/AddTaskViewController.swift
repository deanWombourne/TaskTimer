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


fileprivate struct ClientRow: Equatable, CustomStringConvertible {
    let id: String
    let name: String

    static func == (lhs: ClientRow, rhs: ClientRow) -> Bool {
        return lhs.name == rhs.name && lhs.id == rhs.id
    }

    var description: String { return self.name }

    static let placeholder: ClientRow = ClientRow(id: UUID().uuidString, name: "Choose a client")
}


final class AddTaskViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let clients = Client.all().map { ClientRow(id: "1", name: $0.name) }

        form = Section("Section1")
            <<< PushRow<ClientRow> {
                $0.options = clients
                $0.value = .placeholder
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
    }
}
