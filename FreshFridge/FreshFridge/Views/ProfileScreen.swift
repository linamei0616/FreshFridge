//
//  ProfileHost.swift
//  FreshFridge
//
//  Created by Beatrice Alvares on 12/14/22.
//

import SwiftUI

struct ProfileHost: View {
    @EnvironmentObject var signupVM : SignUpViewModel

    var body: some View {
        let userProfile = Profile(username: signupVM.userDisplayName)
        VStack(alignment: .leading, spacing: 20) {
            ProfileSummary(profile: userProfile)
        }
        .padding()
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
    }
}
