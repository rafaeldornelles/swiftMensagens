//
//  Senac_3_projetoApp.swift
//  Senac-3-projeto
//
//  Created by IOS SENAC on 10/30/21.
//

import SwiftUI
import Firebase

@main
struct Senac_3_projetoApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    class AppDelegate: NSObject, UIApplicationDelegate {
      func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
      }
    }
}
