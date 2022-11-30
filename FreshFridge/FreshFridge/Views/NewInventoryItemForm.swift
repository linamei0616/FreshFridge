//
//  NewInventoryItemForm.swift
//  FridgeView
//
//  Created by 41 Go Team on 11/14/22.
//

// the popup when you want to insert a new item

import SwiftUI

struct NewInventoryItemForm: View {
  @State var question: String = ""
  @State var answer: String = ""
  @Environment(\.presentationMode) var presentationMode
  @ObservedObject var inventoryItemListViewModel: ItemListViewModel

  var body: some View {
    VStack(alignment: .center, spacing: 30) {
      VStack(alignment: .leading, spacing: 10) {
        Text("Grocery Item")
          .foregroundColor(.gray)
        TextField("Enter the item", text: $question)
          .textFieldStyle(RoundedBorderTextFieldStyle())
      }
      VStack(alignment: .leading, spacing: 10) {
        Text("How many?")
          .foregroundColor(.gray)
        TextField("Enter the quantity", text: $answer)
          .textFieldStyle(RoundedBorderTextFieldStyle())
      }

      Button(action: addInventoryItem) {
        Text("Add New Item")
          .foregroundColor(.blue)
      }
      Spacer()
    }
    .padding(EdgeInsets(top: 80, leading: 40, bottom: 0, trailing: 40))
  }

  private func addInventoryItem() {
    // 1
    let inventoryItem = InventoryItem(name: "Apple", quantity: 5)
    // 2
    inventoryItemListViewModel.add(inventoryItem)
    // 3
    presentationMode.wrappedValue.dismiss()
  }
}

struct NewInventoryItemForm_Previews: PreviewProvider {
  static var previews: some View {
    NewInventoryItemForm(inventoryItemListViewModel: ItemListViewModel())
  }
}
