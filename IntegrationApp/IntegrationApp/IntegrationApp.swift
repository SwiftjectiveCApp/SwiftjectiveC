//
//  IntegrationApp.swift
//  IntegrationApp
//
//  Created by Khoa Le on 15/03/2023.
//

import SwiftUI
import AppCore
import Home

@main
struct IntegrationApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @ObservedObject var appController = AppController()

    var body: some Scene {
        WindowGroup {
            if appController.shouldShowHomeView {
                NavigationView {
                    HomeView()
                }

            } else {
                appController.buildAuthenticationView()
            }
        }
    }
}

final class AppDelegate: NSObject, UIApplicationDelegate {
    func applicationDidFinishLaunching(_ application: UIApplication) {
    }
}
