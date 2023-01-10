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
    @Environment(\.presentationMode) var presentationMode
    @State var shareCode: String = ""

    @ViewBuilder
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 10) {
                Text(profile.username)
                    .bold()
                    .font(.title)
                Text("Notifications: \(profile.prefersNotifications ? "On": "Off" )")
//                Text("Food Wasted: \(profile.seasonalPhoto.rawValue)")
                Text("Food Wasted: 0 lbs")
                Text("Food Saved: ") + Text("0 lbs")
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
                    signupVM.signOutWithGoogle()
                }, label: {
                    Text("Sign out")
                })
            }
        }
    }
}

struct ProfileSummary_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSummary(profile: Profile(username: ""))
    }
}
