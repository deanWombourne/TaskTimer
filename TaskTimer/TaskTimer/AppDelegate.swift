//
//  AppDelegate.swift
//  TaskTimer
//
//  Created by Sam Dean on 30/11/2016.
//  Copyright © 2016 deanWombourne. All rights reserved.
//

import UIKit

import Fabric
import Crashlytics

import TaskTimerModel

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {

        if self.isUnderTest {

            let controller = UIViewController()
            controller.view.backgroundColor = .green

            self.window = UIWindow()
            self.window?.rootViewController = controller

            self.window?.makeKeyAndVisible()

            return true
        }

        Fabric.with([Crashlytics.self, Answers.self])

        Answers.logCustomEvent(withName: "Startup", customAttributes: [:])

        TaskTimerModel.initialize()

        return true
    }

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}

extension AppDelegate {

    var isUnderTest: Bool {
        return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }
}
