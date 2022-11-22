//
//  InventoryItemView.swift
//  FridgeView
//
//  Created by 41 Go Team on 11/14/22.
//

//display cards

import Foundation
import SwiftUI

struct InventoryItemView: View {
    //MARK: - Variables
    var inventoryItemViewModel: ItemViewModel
    @State var showContent: Bool = false
    @State var viewState = CGSize.zero
    @State var showAlert = false
    @State var alert = UIAlertController(title: "Confirm", message: "Are you sure you want to delete this?", preferredStyle: .alert)
    
    //MARK: - Colors
    let lightGrey = Color(red: 0.45, green: 0.57, blue: 0.72)
    let pastelBlue = Color(red: 0.77, green: 0.83, blue: 0.92)
    
    //MARK: - Functs
    func alertInformation(name: String, quantity: Int) -> String {
        return name + "\n" + "Quantity: " + quantity.codingKey.stringValue + "\n Expiration Date: " + "\n" + "Tips: "
    }
    
    //MARK: - Body
    var body: some View {
        ZStack(alignment: .center) {
            backView.opacity(showContent ? 1 : 0)
            frontView.opacity(showContent ? 0 : 1)
        }
        .background(Color.orange)
        .cornerRadius(20)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Remove InventoryItem"),
                message: Text("Are you sure you want to remove this inventoryItem?"),
                primaryButton: .destructive(Text("Remove")) {
                    inventoryItemViewModel.remove()
                },
                secondaryButton: .cancel())
        }
    }
    
    var frontView: some View {
        VStack(alignment: .center) {
            Spacer()
            Text(inventoryItemViewModel.item.name)
                .foregroundColor(.white)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(20.0)
            Spacer()
        }
    }
    
    var backView: some View {
        VStack {
            // 1
            Spacer()
            Text(inventoryItemViewModel.item.name)
                .foregroundColor(.white)
                .font(.body)
                .padding(20.0)
                .multilineTextAlignment(.center)
            Spacer()
           
        }
    }
}
