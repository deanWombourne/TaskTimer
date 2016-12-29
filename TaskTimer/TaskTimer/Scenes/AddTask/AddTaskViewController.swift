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

    private var taskDescription: String? {
        let cell = form.rowBy(tag: "taskDescription") as? TextRow
        return cell?.value
    }

    private var availableProjects: [AddTaskEntry<Project>] {
        guard case .some(.existing(let client)) = self.client else {
            return []
        }

        return client.projects.map { AddTaskEntry.existing($0) }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let clients = Client.all().map { AddTaskEntry.existing($0) }
        self.client = clients.first

        form = Section("Client")
            <<< SwitchRow("newClientSwitch") {
                $0.title = "Add new client?"
                $0.value = clients.count == 0
            }
            <<< PushRow<AddTaskEntry<Client>>("client") {
                $0.options = clients
                $0.title = "Client"
                $0.value = self.client
                $0.hidden = .predicate(NSPredicate(format: "$newClientSwitch == true"))
                $0.onChange {
                    self.client = $0.value
                    self.updateProjectRow()
                }
            }
            <<< TextRow("newClient") {
                $0.placeholder = "New client name"
                $0.hidden = .predicate(NSPredicate(format: "$newClientSwitch == false"))
                $0.onChange { self.client = $0.value.map { .create(name: $0) } }
            }
            +++ Section("Project")
            <<< SwitchRow("newProjectSwitch") {
                $0.title = "Create new project?"
                $0.value = false
            }
            <<< PushRow<AddTaskEntry<Project>>("project") {
                $0.options = self.availableProjects
                $0.value = $0.options.first
                $0.title = "Choose existing project"
                $0.disabled = .function(["client"]) { _ in return self.client == nil }
                $0.hidden = .predicate(NSPredicate(format: "$newProjectSwitch == true"))
                $0.onChange { self.project = $0.value }
            }
            <<< TextRow("newProject") {
                $0.placeholder = "New project name"
                $0.hidden = .predicate(NSPredicate(format: "$newProjectSwitch == false"))
                $0.onChange {
                    self.project = $0.value.map { .create(name: $0) }
                }
            }
            +++ Section("Task")
            <<< TextRow("taskDescription") {
                $0.placeholder = "Task description"
            }
            <<< CountDownRow {
                $0.title = "Time taken so far"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
            }
            <<< SwitchRow {
                $0.title = "Aready finished?"
                $0.value = false
            }
            +++ Section()
            <<< DelegatingButtonRow() {
                $0.title = "Create"
                $0.disabled = .function(["client", "newClient", "project", "newProject", "taskDescription"], { !self.validate(form: $0) })
                $0.onSelection { _ in self.createTask() }
        }
    }

    private func updateProjectRow() {
        if let projectRow = self.form.rowBy(tag: "project") as? PushRow<AddTaskEntry<Project>> {
            projectRow.options = self.availableProjects
        }
    }

    private func validate(form: Form) -> Bool {
        guard self.client != nil else {
            return false
        }

        guard self.project != nil else {
            return false
        }

        guard
            let description = self.taskDescription,
            !description.isEmpty else {
                return false
        }

        return true
    }

    private func createTask() {
        guard let description = self.taskDescription else {
            return
        }

        let client = self.client!.command(creator: Client.create())

        let project = client.then { client in
            return self.project!.command(creator: Project.createProject(client: client))
        }

        let task = project.then { project in
            return project.createTask(withName: description)
        }

        task.perform { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let task):
                print(task)
            }
        }
    }
}
