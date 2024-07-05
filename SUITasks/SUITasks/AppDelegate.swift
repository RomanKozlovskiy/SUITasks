//
//  AppDelegate.swift
//  SUITasks
//
//  Created by user on 25.06.2024.
//

import SwiftUI
import YandexMapsMobile

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        YMKMapKit.setApiKey("f7e562f2-54e8-47d0-83d2-9565bb0b5590")
        YMKMapKit.sharedInstance()
        return true
    }
}
