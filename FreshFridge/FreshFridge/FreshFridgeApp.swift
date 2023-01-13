//
//  FreshFridgeApp.swift
//  FreshFridge
//
//  Created by 41 Go Team on 10/19/22.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn

@main
struct FreshFridgeApp: App {
     // register app delegate 
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    // appDelegate?
    @StateObject var model = ItemListViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
                .environmentObject(SignUpViewModel())
                .environmentObject(globalAuth())
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
    @available(iOS 9.0, *)
    // google sign-in auth code
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any])
      -> Bool {
          return GoogleSignIn.GIDSignIn.sharedInstance.handle(url)
    }
}
