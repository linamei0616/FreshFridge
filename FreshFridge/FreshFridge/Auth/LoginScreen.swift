//
//  LoginScreen.swift
//  FreshFridge
//
//  Created by 41 Go Team on 12/9/22.
//

import SwiftUI
import Firebase

struct LoginScreen: View {
    @EnvironmentObject var signupVM: SignUpViewModel
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            Button(action: { login() }) {
                Text("Sign in")
            }
            .padding()
            Button {
                signupVM.signUpWithGoogle()
            } label: {
                Text("Sign in with google")
            }
        }
        .padding()
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                let itemListViewModel = ItemListViewModel()
            }
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
