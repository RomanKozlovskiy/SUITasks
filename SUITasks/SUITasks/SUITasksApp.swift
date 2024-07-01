//
//  SUITasksApp.swift
//  SUITasks
//
//  Created by user on 13.06.2024.
//

import SwiftUI
import Sentry

@main
struct SUITasksApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    init() {
        SentrySDK.start { options in
            options.dsn = "https://9c27f5750d8503b340e6ead405ec07c2@o4507463743373312.ingest.de.sentry.io/4507463745470544"
            options.tracesSampleRate = 1.0
            options.profilesSampleRate = 1.0
        }
    }
    
    var body: some Scene {
        WindowGroup {
            MainCoordinator().view()
        }
    }
}
