//
//  GroceryItemLabel.swift
//  FridgeView
//
//  Created by 41 Go Team on 11/18/22.
//

import Foundation
import SwiftUI

struct GroceryItemLabel: View {
    let pastelBlue = Color(red: 0.77, green: 0.83, blue: 0.92)
    var name:String = ""
    var image:String = ""
    let lightGrey = Color(red: 0.45, green: 0.57, blue: 0.72)
    let id:String = ""
    let expirationDate:Int
    
//    self.expirationDate = ExpDates[name] ?? 10 // default value: 10
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(pastelBlue)
            .overlay(VStack{
                Text(name)
                HStack {
                    if (expirationDate <= 7) {
                        Text(String(expirationDate))
                            .foregroundColor(Color.red)
                    } else {
                        Text(String(expirationDate))
                            .foregroundColor(lightGrey)
                    }
                    Text("days remaining")
                        .foregroundColor(lightGrey)
                }
            }
                    )
            .font(.system(size: 18))
            .padding()
            .frame(height: 90)
    }
}
