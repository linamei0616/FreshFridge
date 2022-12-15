//
//  ProfileScreen.swift
//  FreshFridge
//
//  Created by 41 Go Team on 12/14/22.
//

import SwiftUI

struct ProfileScreen: View {
    var body: some View {
        VStack {
            VStack {
                Header()
                ProfileText()
            }
            Spacer()
        }
    }
}
struct ProfileText: View {
    @AppStorage("name") var name = DefaultSettings.name
    @AppStorage("subtitle") var subtitle = DefaultSettings.subtitle
    @AppStorage("description") var description = DefaultSettings.description
    
    var body: some View {
        VStack(spacing: 15) {
            VStack(spacing: 5) {
                Text(name)
                    .bold()
                    .font(.title)
                Text(subtitle)
                    .font(.body)
                    .foregroundColor(.secondary)
            }.padding()
            Text(description)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
        }
    }
}
struct Header: View {
    @AppStorage("rValue") var rValue = DefaultSettings.rValue
    @AppStorage("gValue") var gValue = DefaultSettings.gValue
    @AppStorage("bValue") var bValue = DefaultSettings.bValue
    
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .foregroundColor(Color(red: rValue, green: gValue, blue: bValue, opacity: 1.0))
                .edgesIgnoringSafeArea(.top)
                .frame(height: 100)
            Image("profile")
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
        }
    }
}
enum DefaultSettings {
    // Color Slider Values
    static var rValue: Double = 150.0
    static var gValue: Double = 150.0
    static var bValue: Double = 150.0
    
    // Profile
    static var name: String = "Johny Appleseed"
    static var subtitle: String = "Developer"
    static var description: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Non arcu risus quis varius quam. Faucibus ornare suspendisse sed nisi lacus sed viverra tellus. Ornare suspendisse sed nisi lacus sed viverra tellus. Arcu odio ut sem nulla pharetra. Vitae congue mauris rhoncus aenean vel elit. Scelerisque eu ultrices vitae auctor eu."
}
struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
    }
}
