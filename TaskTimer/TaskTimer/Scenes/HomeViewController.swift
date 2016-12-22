//
//  FirstViewController.swift
//  TaskTimer
//
//  Created by Sam Dean on 30/11/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import Foundation
import UIKit


fileprivate enum Section {
    case active(tasks: [Task])
    case recent(tasks: [Task])

    var count: Int {
        switch self {
        case .active(let tasks): return max(tasks.count, 1)
        case .recent(let tasks): return max(tasks.count, 1)
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self {
        case .active(let tasks) where tasks.count == 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
            cell.textLabel?.text = "You're not doing anything at the moment"
            return cell

        case .active(let tasks):
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

            return cell


        case .recent(let tasks) where tasks.count == 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
            cell.textLabel?.text = "No recent tasks found"
            return cell

        case .recent(let tasks):
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

            return cell
        }
    }

    var title: String {
        switch self {
        case .active: return "Active"
        case .recent: return "Recent"
        }
    }
}


final class HomeViewController: UIViewController {

    @IBOutlet fileprivate var tableView: UITableView?

    fileprivate var sections: [Section] = [] {
        didSet {
            self.tableView?.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.refreshSections()
    }

    private func refreshSections() {
        self.sections = [
            // Get the current active tasks
            .active(tasks: []),

            // Get the recent tasks
            .recent(tasks: [])
        ]
    }
}


extension HomeViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.sections[indexPath.section].tableView(tableView, cellForRowAt: indexPath)
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section].title
    }
}


extension HomeViewController: UITableViewDelegate {
    
}
