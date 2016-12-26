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

    private var client: AddTaskEntry<Client>?
    private var project: AddTaskEntry<Project>?

    override func viewDidLoad() {
        super.viewDidLoad()

        let clients = Client.all().map { AddTaskEntry.existing($0) }

        form = Section("Client")
            <<< PushRow<AddTaskEntry<Client>>("client") {
                $0.options = clients
                $0.title = "Client"
                $0.hidden = Condition(booleanLiteral: clients.count == 0)
                $0.onChange { row in
                    self.client = row.value
                }
            }
            <<< TextRow("new-client") {
                $0.placeholder = "New client name"
                $0.hidden = Condition(booleanLiteral: clients.count != 0)
            }
            +++ Section("Project")
            <<< SwitchRow("newProjectSwitch") {
                $0.title = "Create new project?"
                $0.value = false
            }
            <<< PushRow<AddTaskEntry<Project>>("project") {
                $0.options = []
                $0.title = "Choose existing project"
                $0.disabled = .function(["client"]) { form in
                    return self.client != nil
                }
                $0.hidden = .predicate(NSPredicate(format: "$newProjectSwitch == false"))
            }
            <<< TextRow("new-project") {
                $0.placeholder = "New project name"
                $0.hidden = .predicate(NSPredicate(format: "$newProjectSwitch == true"))
            }
            +++ Section("Task")
            <<< CountDownRow {
                $0.title = "Time taken so far"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
            }
            <<< TextRow("new-task") {
                $0.placeholder = "Task description"
            }
            <<< SwitchRow {
                $0.title = "Aready finished?"
                $0.value = false
            }
            +++ Section()
            <<< ButtonRow("create") {
                $0.title = "Create"
        }
    }
}
