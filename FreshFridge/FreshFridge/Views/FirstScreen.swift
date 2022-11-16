//
//  FirstScreen.swift
//  FreshFridge
//
//  Created by 41 Go Team on 11/6/22.
//
import FirebaseCore
import SwiftUI

struct FirstScreen: View {
    var body: some View {
//        let persistenceController = PersistenceController.shared
        let textBlue = Color(red: 0.46, green: 0.62, blue: 0.85)
        let lightBlue = Color(red: 0.45, green: 0.57, blue: 0.72)
        NavigationView{
            ZStack {
                VStack {
                    Text("Fridge View")
                        .font(Font.custom("Signika", size: 60).weight(.bold))
                        .fontWeight(.heavy)
                        .foregroundColor(textBlue)
                        .multilineTextAlignment(.center)
                        .padding([.leading, .trailing], 30)
                        .padding(.bottom, 240)
                    // add picture of fridge handle in between here
                    NavigationLink(destination:
                                        MainView()) {
//                                        .environment(\.managedObjectContext, persistenceController.container.viewContext)

    //                        Button("Get Started") {
    //                    }
    //                        .padding()
    //                        .background(Color.white)
    //                        .foregroundColor(.black)
    //                        .background(lightBlue)
    //                        .cornerRadius(40)
    //                    }
                          RoundedRectangle(cornerRadius: 20)
                             .fill(lightBlue)
                             .frame(height: 50)
                             .frame(width: 300, height: 50)
                              .overlay(Text("Get Started"))
                             .foregroundColor(Color.white)
                           .font(Font.custom("Signika", size: 25).weight(.bold))
                    }
                }
            }
        }
    }
}

struct FirstScreen_Previews: PreviewProvider {
    static var previews: some View {
        FirstScreen()
    }
}
