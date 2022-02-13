//
//  ElibApp.swift
//  Elib
//
//  Created by Daniil Akmatov on 7/2/22.
//

import SwiftUI
import Firebase
import UIKit

@main
struct ElibApp: App {
    
    // Create a reference to the App Delegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Configure FirebaseApp
        FirebaseApp.configure()
        return true
    }
}
