//
//  SignUpViewModel.swift
//  FreshFridge
//
//  Created by 41 Go Team on 12/9/22.
//

import Foundation
import SwiftUI
import Firebase
import GoogleSignIn

//public var authUser = Auth.auth().currentUser

class globalAuth: ObservableObject {
//    static let shared = globalAuth() // creates a singleton object
    @Published var currUser = Auth.auth().currentUser
//    @State var authUser = Auth.auth().currentUser
    func signingOut() {
        print("signingOut() ran")
        DispatchQueue.main.async {
            self.currUser = nil
        }
    }
    func loggedIn() {
        print("LoggedIn() ran")
        print(currUser as Any)
    }
}

class SignUpViewModel: ObservableObject {
    
    enum SignInState {
      case signedIn
      case signedOut
    }

    @Published var userID: String = ""
    @Published var userDisplayName: String = ""
    @Published var state: SignInState = .signedOut
    
    
//    func updateAuth(newUser: User) {
//        globalAuth.shared.authUser = newUser
//        print(newUser as Any)
//    }
//    func signOutAuth() {
//        globalAuth.shared.authUser = nil
//        print(globalAuth.shared.authUser as Any)
//    }
//    func retrieveAuth() -> User? {
//        guard let result = globalAuth.shared.authUser else { return nil }
//        return result
//    }
    
    func signInWithApple() {
//        userID = user.uid
        userDisplayName = "Jane Doe"
        state = .signedIn
    }
    
    func signOutWithGoogle() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            print("User has signed out")
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        self.userID = ""
        self.state = .signedOut
//        print("success signing out")
    }

    func signUpWithGoogle() {
        // get app client id
        guard let clientId = FirebaseApp.app()?.options.clientID else { return }
        
        // get configuration
        let config = GIDConfiguration(clientID: clientId)
        
        //SignIn
        GIDSignIn.sharedInstance.signIn(with: config, presenting: ApplicationUtility.rootViewController) {
            [unowned self] user, err in
            
            if let error = err {
                print(error.localizedDescription)
                return
            }

            guard
              let authentication = user?.authentication,
              let idToken = authentication.idToken
            else {
              return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if error != nil {
                    print (err?.localizedDescription as Any)
                    return
                }
                guard let user = authResult?.user else { return }
                print(user.displayName as Any)
                self.userID = user.uid
                self.userDisplayName = user.displayName ?? "Jane Doe"
                self.state = .signedIn
            }
        }
    }
}
