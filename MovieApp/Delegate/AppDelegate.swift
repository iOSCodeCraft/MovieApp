//
//  AppDelegate.swift
//  MovieApp
//
//  Created by manya on 02/03/24.
//

/*
 access token : eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0ZDNmOTlmYjhlNGM3ZmE5NjQ2OTc1ZDcxNjk0MmY3YSIsInN1YiI6IjY1ZTRjNzhiZmUwNzdhMDE2MjBmNWJlYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.9g731miXGHo7gcFbBYgQyeCPH8JzPO55mXw6u5T3mWU
 api key : 4d3f99fb8e4c7fa9646975d716942f7a
 */

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
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

