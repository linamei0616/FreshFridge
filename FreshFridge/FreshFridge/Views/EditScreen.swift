//
//  EditScreen.swift
//  FreshFridge
//
//  Created by 41 Go Team on 12/14/22.
//

import SwiftUI

struct EditScreen: View {
    @ObservedObject var inventoryItemListViewModel: ItemListViewModel
    let item: ItemViewModel? // this is now a parameter
    var itemName: String = ""
    @State var quantity: String = ""
    @State var expDate: String = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        
        VStack(alignment: .center, spacing: 30) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Grocery Item")
                        .foregroundColor(.gray)
                TextField("Enter the new quantity", text: $quantity)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            VStack(alignment: .leading, spacing: 10) {
                Text("Enter the new expiration date")
                        .foregroundColor(.gray)
                TextField("Expires in", text: $expDate)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            Button {
                update(item: item!.item)
            } label: {
                Text("Confirm")
            }
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Cancel")
            }
            Spacer()
        }
        .padding(EdgeInsets(top: 80, leading: 40, bottom: 0, trailing: 40))
    }
    
    func update(item: InventoryItem) {
//        let item = InventoryItem(name: item.name, quantity: Int(quantity) ?? 0, exp: Int(expDate) ?? 10)
        inventoryItemListViewModel.update(item)
//        let item = InventoryItem(name: question, quantity: Int(answer) ?? 0, exp: ExpDates[question] ?? 10)
//        inventoryItemListViewModel.add(inventoryItem)
//        inventoryItemListViewModel.makenotification(inventoryItem)

//        item =
//        itemRepository.update(item)
    }
    
}

struct EditScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditScreen(inventoryItemListViewModel: ItemListViewModel(), item: nil)
    }
}
