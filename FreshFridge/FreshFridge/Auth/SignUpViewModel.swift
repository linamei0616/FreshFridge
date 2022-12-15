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

class SignUpViewModel: ObservableObject {
    
    enum SignInState {
      case signedIn
      case signedOut
    }

    @Published var userID: String = ""
    @Published var itemRepository = ItemRepository()
    @Published var state: SignInState = .signedOut

    
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
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
                self.state = .signedIn
//                self.isLogin.toggle()
                //                self.itemRepository.auth(id: user.uid)
            }
        }
    }
}
