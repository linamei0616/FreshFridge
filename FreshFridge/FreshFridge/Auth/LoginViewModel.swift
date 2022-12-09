//
//  LoginViewModel.swift
//  FreshFridge
//
//  Created by 41 Go Team on 12/9/22.
//

import Foundation
import SwiftUI
import Firebase
import GoogleSignIn

class SignUpViewModel: ObservableObject {
    @Published var isLOgin: Bool = false
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
                if let error = error {
                    print (err?.localizedDescription as Any)
                    return
                }
                guard let user = authResult?.user else { return }
                print(user.displayName as Any)
//                isLogin.toggle()
            }
        }
    }
}
