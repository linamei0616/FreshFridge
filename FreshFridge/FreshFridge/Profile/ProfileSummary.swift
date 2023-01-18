//
//  ProfileSummary.swift
//  FreshFridge
//
//  Created by Beatrice Alvares on 12/14/22.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct ProfileSummary: View {
    @State var profile: Profile
    @EnvironmentObject var signupVM : SignUpViewModel
    @EnvironmentObject var userAuth : globalAuth
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("wasted") var wastedItems : Int = 0
    @AppStorage("saved") var savedItems : Int = 0

    
    
    @State var shareCode: String = ""
//    @Binding var auth : User?
    
    func signOutWithApple() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            print("signing out")
            userAuth.signingOut()
//            userAuth.currUser = nil
//            auth = nilx
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
//        self.userID = ""
//        self.state = .signedOut
//        print("success signing out")
        print("finished sign out with apple function")
    }
    
    @ViewBuilder
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 10) {
                Text(profile.username)
                    .bold()
                    .font(.title)
                Text("Notifications: \(profile.prefersNotifications ? "On": "Off" )")
//                Text("Food Wasted: \(profile.seasonalPhoto.rawValue)")
                Text("Food Wasted: \(wastedItems)")
                Text("Food Saved: \(savedItems)")
//                Text(profile.goalDate, style: .date)
                Divider()
                                VStack(alignment: .leading) {
                                    Text("Completed Badges")
                                        .font(.headline)

                                    ScrollView(.horizontal) {
                                        HStack(alignment: .center) {
                                            Badges(name: "Joined")
//                                            Badges(name: "Earth Day")
//                                                .hueRotation(Angle(degrees: 90))
//                                            Badges(name: "Tenth Hike")
//                                                .grayscale(0.5)
//                                                .hueRotation(Angle(degrees: 45))
                                        }
                                        .padding(.bottom)
                                    }
                                }
                Text("Share")
                    .font(.headline)
                Text("Enter a friend's code to share fridges!")
                    .font(.subheadline)
                TextField("Enter a friend's code", text: $shareCode)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .padding()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
//                    signupVM.signOutWithGoogle()
                    signOutWithApple()
                }, label: {
                    Text("Sign out")
                })
            }
        }
    }
}
//
//struct ProfileSummary_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileSummary(profile: Profile(username: ""))
//    }
//}
