//
//  ProfileHost.swift
//  FreshFridge
//
//  Created by 41 Go Team on 11/6/22.
//

import SwiftUI


struct ProfileHost: View {
    @State private var draftProfile = Profile.default

    var body: some View {
        Text("Profile for: \(draftProfile.username)")
    }
}



struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
    }
}
