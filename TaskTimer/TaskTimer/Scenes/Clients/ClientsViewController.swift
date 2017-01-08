//
//  ClientsViewController.swift
//  TaskTimer
//
//  Created by Sam Dean on 08/01/2017.
//  Copyright © 2017 deanWombourne. All rights reserved.
//

import Foundation
import UIKit

import TaskTimerModel


final class ClientsListViewController: UIViewController {

    @IBOutlet private var tableView: UITableView?

    fileprivate var clients: [Client] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.clients = Client.allClients
    }

}

extension ClientsListViewController: UITableViewDelegate, UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.clients.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Client", for: indexPath)

        cell.textLabel?.text = self.clients[indexPath.row].name

        return cell
    }
}
