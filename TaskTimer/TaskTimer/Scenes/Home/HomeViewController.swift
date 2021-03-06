//
//  FirstViewController.swift
//  TaskTimer
//
//  Created by Sam Dean on 30/11/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import Foundation
import UIKit

import TaskTimerModel

final class HomeViewController: UIViewController {

    @IBOutlet fileprivate var tableView: UITableView?

    fileprivate var sections: [HomeSection] = [] {
        didSet {
            self.tableView?.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.refreshSections()

        self.tableView?.estimatedRowHeight = 44
        self.tableView?.rowHeight = UITableViewAutomaticDimension
    }

    private func refreshSections() {
        self.sections = [
            .active(tasks: Task.allActive()),
            .recent(tasks: Task.allRecent())
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

extension HomeViewController {

    @IBAction func unwindToHome(segue: UIStoryboardSegue!) {
    }
}
