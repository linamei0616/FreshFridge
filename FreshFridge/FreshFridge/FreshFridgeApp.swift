//
//  FreshFridgeApp.swift
//  FreshFridge
//
//  Created by 41 Go Team on 10/19/22.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}


@main
struct FreshFridgeApp: App {
    let persistenceController = PersistenceController.shared
     // register app delegate for Firebase setup
     @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView(itemListViewModel: ItemListViewModel())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
