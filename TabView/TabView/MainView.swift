//
//  MainView.swift
//  TabView
//
//  Created by 41 Go Team on 10/6/22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            GreenScreen()
                .tabItem {
                    Image(systemName: "play.rectangle.fill")
                    Text("Video")
                }
            YellowScreen()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            BlueScreen()
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("Info")
                }
            BlackScreen()
                .tabItem {
                    Image(systemName: "book")
                    Text("Resources")
                }
            OrangeScreen()
                .tabItem {
                    Image(systemName: "cloud")
                    Text("Weather")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
