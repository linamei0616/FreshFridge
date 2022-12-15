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
    var profile: Profile
    @EnvironmentObject var signupVM : SignUpViewModel
    @Environment(\.presentationMode) var presentationMode

    @ViewBuilder
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(profile.username)
                    .bold()
                    .font(.title)
                Text("Notifications: \(profile.prefersNotifications ? "On": "Off" )")
                Text("Food Wasted: \(profile.seasonalPhoto.rawValue)")
                Text("Food Saved: ") + Text(profile.goalDate, style: .date)
                Divider()
                                VStack(alignment: .leading) {
                                    Text("Completed Badges")
                                        .font(.headline)

                                    ScrollView(.horizontal) {
                                        HStack {
                                            Badges(name: "First Hike")
                                            Badges(name: "Earth Day")
                                                .hueRotation(Angle(degrees: 90))
                                            Badges(name: "Tenth Hike")
                                                .grayscale(0.5)
                                                .hueRotation(Angle(degrees: 45))
                                        }
                                        .padding(.bottom)
                                    }
                                }
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                    signupVM.signOut()
                }, label: {
                    Text("Sign out")
                })
            }
        }
    }
}

struct ProfileSummary_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSummary(profile: Profile.default)
    }
}
