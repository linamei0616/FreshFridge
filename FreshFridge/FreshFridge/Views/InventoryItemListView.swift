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
//    @State var groceryList: [GroceryItem] = GroceryItem.getFruits() // Salvador's
//    @State var groceryItem = "" // Salvador's
//    @State var groceryQuantity = 0 // Salvador's
    @State var alert = UIAlertController(title: "Confirm", message: "Are you sure you want to delete this?", preferredStyle: .alert)
    @State private var showingAlert = false
    @State var search = "" // Search Bar
    
    //MARK: - Colors
    let lightGrey = Color(red: 0.45, green: 0.57, blue: 0.72)
    let pastelBlue = Color(red: 0.77, green: 0.83, blue: 0.92)
    
    //7. Update the dataType for the computed property from String to GroceryItem.
//    var searchResults: [GroceryItem]{
//        if search.isEmpty{
//            return groceryList
//        } else{
//            return groceryList.filter {
//                //8. Add the name property to filter from the name
//                $0.name.lowercased().contains( search.lowercased())
//            }
//        }
//    }
//
//    //MARK: - Salvador Functions
//    func addItemtoList(){
//        if groceryItem != ""{
//            groceryList.append(GroceryItem(name: groceryItem, quantity: groceryQuantity, image: "apple", color: .green, description: "N/A"))
//            groceryItem = ""
//            groceryQuantity = 1
//        }
//    }
//    func delete(at indexes: IndexSet){
//        if let first = indexes.first{
//            groceryList.remove(at: first)
//        }
//    }
//    func move(from index: IndexSet, to destination: Int){
//        groceryList.move(fromOffsets: index, toOffset: destination)
//    }
    
    //MARK: - Firebase functs
    func addItem() {
        withAnimation {
//            let newItem = InventoryItem(question: "Grocery Item?", answer: "banana")
        }
    }
    
    func addInventoryItem() {
        let item = InventoryItem(name: "apple", quantity: 5)
        inventoryItemListViewModel.add(item)
    }
    
    func deleteItems(offsets: IndexSet) {
        withAnimation {
        }
    }
    
    func alertInformation(name: String, quantity: Int) -> String {
        return name + "\n" + "Quantity: " + quantity.codingKey.stringValue + "\n Expiration Date: " + "\n" + "Tips: "
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
                                        GroceryItemLabel(name: result.item.name, image: "")
                                    }
                                    .foregroundColor(lightGrey)
//                                    .alert(alertInformation(name: result.item.name, quantity: result.item.quantity),isPresented: $showingAlert) {
//                                        Button("Confirm", role: .cancel) { }
//                                    }
                                    .alert(isPresented: $showingAlert) {
                                        Alert(
                                            title: Text("Remove InventoryItem"),
                                            message: Text("Are you sure you want to remove this inventoryItem?"),
                                            primaryButton: .destructive(Text("Remove")) {
                                                inventoryItemViewModel?.remove()
                                            },
                                            secondaryButton: .cancel())
                                    }
                                //                            ForEach(inventoryItemListViewModel.itemViewModels) { inventoryItemViewModel in
                                //                                InventoryItemView(inventoryItemViewModel: inventoryItemViewModel)
                                //                                GroceryItemLabel(name: inventoryItemViewModel.item.name, image: "")
                                
                            }
//                            .onDelete(perform: delete)
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
