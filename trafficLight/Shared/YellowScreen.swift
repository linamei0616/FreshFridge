//
//  YellowScreen.swift
//  trafficLight
//
//  Created by 41 Go Team on 10/6/22.
//

import SwiftUI

struct YellowScreen: View {
    var body: some View {
        ZStack {
            Color.yellow
            NavigationLink(destination: RedScreen()) {
                Text("Go to RedScreen")
            }
        }
    }
}

struct YellowScreen_Previews: PreviewProvider {
    static var previews: some View {
        YellowScreen()
    }
}
