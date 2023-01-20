//
//  OnboardingViewTwo.swift
//  Onboarding Quality Weather
//
//  Created by Rinalds Domanovs on 16/04/2021.
//
//<a href="https://www.freepik.com/free-vector/notebook-concept-illustration_5421749.htm#query=list&position=27&from_view=author">Image by storyset</a> on Freepik

import SwiftUI

struct OnboardingViewTwo: View {
    @State private var isAnimating: Bool = false
    @AppStorage("onboard") var showOnboard : Bool = true

    var body: some View {
        VStack(spacing: 20.0) {
            ZStack {
                Image("list")
                    .resizable()
                    .scaledToFit()
                    .offset(x: 0, y: 150)
                    .scaleEffect(isAnimating ? 1 : 0.9)
            }

            Spacer()
            Spacer()

            Text("Track groceries")
                .font(.title2)
                .bold()
                .foregroundColor(Color(red: 41 / 255, green: 52 / 255, blue: 73 / 255))

            Text("A neat and organized way to view all your groceries in one place. Swipe left to mark and swipe right to delete.")
                .font(.headline)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 250)
                .foregroundColor(Color(red: 237 / 255, green: 203 / 255, blue: 150 / 255))
                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 2, y: 2)

            Spacer()
            
            Button(action: {
                showOnboard.toggle()
            }, label: {
                Text("Get Started")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 50)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(
                                Color(
                                    red: 255 / 255,
                                    green: 115 / 255,
                                    blue: 115 / 255
                                )
                            )
                    )
            })
            .shadow(radius: 10)

            Spacer()
        }
        .onAppear(perform: {
            isAnimating = false
            withAnimation(.easeOut(duration: 0.5)) {
                self.isAnimating = true
            }
        })
    }
}

struct OnboardingViewTwo_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingViewTwo()
    }
}
