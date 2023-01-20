//
//  Onboarding.swift
//  FreshFridge
//
//  Created by 41 Go Team on 1/19/23.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentTab = 0
    @Binding var shouldShowOnboarding: Bool

    var body: some View {
        TabView(selection: $currentTab,
                content:  {
                    OnboardingViewOne()
                        .tag(0)
                    OnboardingViewTwo()
                        .tag(1)
                    OnboardingViewThree()
                        .tag(3)
                })
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingView()
//    }
//}
