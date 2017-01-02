//
//  ViewController+alert.swift
//  TaskTimer
//
//  Created by Sam Dean on 29/12/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    func alert(title: String, message: String, completion: @escaping () -> Void ) {

        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        controller.addAction(cancel)

        let ok = UIAlertAction(title: "OK", style: .default) { _ in completion() }
        controller.addAction(ok)

        self.present(controller, animated: true, completion: nil)
    }
}
