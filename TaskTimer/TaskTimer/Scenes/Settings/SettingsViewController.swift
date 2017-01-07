//
//  SecondViewController.swift
//  TaskTimer
//
//  Created by Sam Dean on 30/11/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import Foundation
import UIKit

import Eureka

import TaskTimerModel

final class SettingsViewController: FormViewController {

    private func sizeOfFile(atURL fileURL: URL) -> Int64? {
        do {
            let attributes = try FileManager.default.attributesOfItem(atPath: fileURL.path)

            guard let size = attributes[FileAttributeKey.size] as? NSNumber else {
                return nil
            }

            return size.int64Value
        } catch {
            return nil
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let fileURL = TaskTimerModel.storageURL
        let fileSize = self.sizeOfFile(atURL: fileURL)

        self.form = Section("Storage")
            <<< TextRow {
                $0.title = "Disk use"
                $0.value = fileSize?.displayBytes() ?? "Unknown"
                $0.disabled = true
            }
            <<< DelegatingButtonRow {
                $0.title = "Clear"
                $0.onSelection { _ in
                    self.alert(title: "Clear?", message: "This will lose all your data. Are you sure?") {
                        TaskTimerModel.reset()
                    }
                }
            }
            +++ Section()
    }
}
