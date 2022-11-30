//
//  MainView.swift
//  FreshFridge
//
//  Created by 41 Go Team on 11/6/22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
//        let textBlue = Color(red: 0.46, green: 0.62, blue: 0.85)
        let lightBlue = Color(red: 0.45, green: 0.57, blue: 0.72)
        TabView{
            ContentView(itemListViewModel: ItemListViewModel())
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
    }
}

