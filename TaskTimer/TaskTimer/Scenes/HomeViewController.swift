//
//  FirstViewController.swift
//  TaskTimer
//
//  Created by Sam Dean on 30/11/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import Foundation
import UIKit


private enum Section {
    case active(tasks: [Task])
    case recent(tasks: [Task])

    var count: Int {
        switch self {
        case .active(let tasks): return tasks.count
        case .recent(let tasks): return tasks.count
        }
    }
}


final class HomeViewController: UIViewController {

    fileprivate var sections: [Section] = []

}


extension HomeViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        return cell
    }
}


extension HomeViewController: UITableViewDelegate {

}
