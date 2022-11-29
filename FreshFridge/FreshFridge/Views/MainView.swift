//
//  MainView.swift
//  FreshFridge
//
//  Created by Beatrice Alvares on 11/21/22.
//


import SwiftUI

struct MainView: View {
    var body: some View {
//        let textBlue = Color(red: 0.46, green: 0.62, blue: 0.85)
        let lightBlue = Color(red: 0.45, green: 0.57, blue: 0.72)
        TabView{
            ContentView()
                .tabItem {
                    Image(systemName: "house")
//                    Text("Home")
                }
//            RecipeView()
//                .tabItem {
//                    Image(systemName: "")
//                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                }
            }
        .accentColor(lightBlue)
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(ItemListViewModel())
    }
}
