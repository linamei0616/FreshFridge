//
//  ProfileView.swift
//  FreshFridge
//
//  Created by 41 Go Team on 11/6/22.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        Text("This is Profile Screen")
        /* for signing out
         let firebaseAuth = Auth.auth()
     do {
       try firebaseAuth.signOut()
     } catch let signOutError as NSError {
       print("Error signing out: %@", signOutError)
     }
       
         */
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
