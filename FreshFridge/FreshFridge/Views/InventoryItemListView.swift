//
//  InventoryItemListView.swift
//  FridgeView
//
//  Created by 41 Go Team on 11/14/22.
//

import Foundation
import SwiftUI
import Firebase

struct InventoryItemListView: View {
    
    //MARK: - Variables
    @EnvironmentObject var inventoryItemListViewModel : ItemListViewModel // firebase model
    var inventoryItemViewModel: ItemViewModel? = nil

    @State var showForm = false
    @State private var showingAlert = false
    @State var search = "" // Search Bar
    
    //MARK: - Colors
    let lightGrey = Color(red: 0.45, green: 0.57, blue: 0.72)
    let pastelBlue = Color(red: 0.77, green: 0.83, blue: 0.92)
    
    //MARK: - Firebase functs
    // I commented this because I think the actual add function is in NewInventoryItemForm?
//    func addInventoryItem() {
//        let item = InventoryItem(name: "apple", quantity: 5)
//        inventoryItemListViewModel.add(item)
//    }
    
//    func deleteItems() {
//        let item = InventoryItem(name: "banana" , quantity: 5 )
//        inventoryItemListViewModel.remove(item)
//    }
    
    func alertInformation(name: String, quantity: Int, expirationDate: Int) -> String {
        return "Quantity: " + quantity.codingKey.stringValue + "\n Days Remaining: "  + String(expirationDate) + "\n" + "Tips: "
        //+ ExpDates[name]?.codingKey.stringValue
    }
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                //MARK: - Firebase
                GeometryReader { geometry in
                    ScrollView(.vertical) {
                        VStack(spacing: 10) {
                            ForEach(inventoryItemListViewModel.itemViewModels) {
                                result in Button(action: {
                                    showingAlert=true }) {
                                        GroceryItemLabel(name: result.item.name, image: "", expirationDate: ExpDates[result.item.name] ?? 10)
                                    }
                                    .foregroundColor(lightGrey)
                                    .alert(isPresented: $showingAlert) {
                                        Alert(
                                            title: Text(result.item.name),
                                            message: Text(alertInformation(name: result.item.name, quantity: result.item.quantity, expirationDate: ExpDates[result.item.name] ?? 10)),
                                            primaryButton: .destructive(Text("Edit")) {
                                                inventoryItemViewModel?.remove()
                                            },
                                            secondaryButton: .cancel())
                                    }
                            }
//                            .onDelete(perform: deleteItems())
//                            .onMove(perform: move)
                            .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always))
                        }
                    }
                }
            }
            // when button is pressed
            .sheet(isPresented: $showForm) {
                NewInventoryItemForm(inventoryItemListViewModel: ItemListViewModel())
            }
            .navigationBarTitle("Your Fridge")
            .navigationBarItems(trailing: Button(action: { showForm.toggle() }) {
                Image(systemName: "plus")
                    .font(.title)
            })
//            .navigationBarItems(trailing: Button(action: { showForm.toggle() }) {
//                Image(systemName: "minus")
//                    .font(.title)
//            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct InventoryItemListView_Previews: PreviewProvider {
  static var previews: some View {
      InventoryItemListView()
          .environmentObject(ItemListViewModel())
  }
}
