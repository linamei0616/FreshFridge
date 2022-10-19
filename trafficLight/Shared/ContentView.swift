//
//  ContentView.swift
//  Shared
//
//  Created by 41 Go Team on 10/6/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.green
                NavigationLink(destination: YellowScreen()) {
                    Text("Go to Yellow")
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Green")
            .navigationBarTitleDisplayMode(.inline)
        }
        .ignoresSafeArea()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
