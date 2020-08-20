//
//  AppDelegate.swift
//  tableView example
//
//  Created by jose sanchez on 8/4/20.
//  Copyright © 2020 jose sanchez. All rights reserved.
//

import UIKit
import CoreData
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var mainPersistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavoritesModel")
        container.loadPersistentStores {
            description, error in
            if let error = error {
                fatalError("Can't load persistent stores: \(error)")
            }
        }
        return container
    }() //mostly obtained from developer.apple.com setting up core data stack doc

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        ///TODO - pass CoreData to ViewControllers (look in the internet?)
//        if let rootVC = window?.rootViewController as? ViewController {
//            rootVC.container = mainPersistentContainer
//        }
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

