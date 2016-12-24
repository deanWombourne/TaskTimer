//
//  HomeSection.swift
//  TaskTimer
//
//  Created by Sam Dean on 22/12/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import Foundation
import UIKit


enum HomeSection {
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

        case .active(let tasks) where indexPath.row < tasks.count:
            let task = tasks[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = task.name

            return cell

        case .recent(let tasks) where tasks.count == 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
            cell.textLabel?.text = "No recent tasks found"
            return cell

        case .recent(let tasks) where indexPath.row < tasks.count:
            let task = tasks[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = task.name

            return cell

        default:
            return tableView.dequeueReusableCell(withIdentifier: "Error") ?? UITableViewCell(style: .default, reuseIdentifier: "Error")
        }
    }

    var title: String {
        switch self {
        case .active: return "Active"
        case .recent: return "Recent"
        }
    }
}
