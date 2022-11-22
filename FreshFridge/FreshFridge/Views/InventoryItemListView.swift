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
    @ObservedObject var inventoryItemListViewModel = ItemListViewModel() // firebase model
    @State var showForm = false
    @State var groceryList: [GroceryItem] = GroceryItem.getFruits() // Salvador's
    @State var groceryItem = "" // Salvador's
    @State var groceryQuantity = 0 // Salvador's
    @State var alert = UIAlertController(title: "Confirm", message: "Are you sure you want to delete this?", preferredStyle: .alert)
    @State private var showingAlert = false
    @State var search = "" // Search Bar
    
    //MARK: - Colors
    let lightGrey = Color(red: 0.45, green: 0.57, blue: 0.72)
    let pastelBlue = Color(red: 0.77, green: 0.83, blue: 0.92)
    
    //7. Update the dataType for the computed property from String to GroceryItem.
    var searchResults: [GroceryItem]{
        if search.isEmpty{
            return groceryList
        } else{
            return groceryList.filter {
                //8. Add the name property to filter from the name
                $0.name.lowercased().contains( search.lowercased())
            }
        }
    }
    
    //MARK: - Salvador Functions
    func addItemtoList(){
        if groceryItem != ""{
            groceryList.append(GroceryItem(name: groceryItem, quantity: groceryQuantity, image: "apple", color: .green, description: "N/A"))
            groceryItem = ""
            groceryQuantity = 1
        }
    }
    func delete(at indexes: IndexSet){
        if let first = indexes.first{
            groceryList.remove(at: first)
        }
    }
    func move(from index: IndexSet, to destination: Int){
        groceryList.move(fromOffsets: index, toOffset: destination)
    }
    
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
                Spacer()
                //14. Comment the add section
                HStack{
                    //MARK: - Temporary Add Grocery Item
                    TextField("add grocery item", text: $groceryItem)
                        .textFieldStyle(.roundedBorder)
                        .onSubmit {
                            addItemtoList()
                        }
                    Button {
                        addItemtoList()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(Color.green)
                    }
                }
                
                //MARK: - Displaying static results temporarily
                ForEach(searchResults) { result in
                    Button(action: {
                        showingAlert=true
                    }) {
                        GroceryItemLabel(name: result.name, image: "")
                    }
                    .foregroundColor(lightGrey)
                    .alert(alertInformation(name: result.name, quantity: result.quantity),isPresented: $showingAlert) {
                        Button("Confirm", role: .cancel) { }
                    }
                }
                .onDelete(perform: delete)
                .onMove(perform: move)
                .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always))
                
                //MARK: - Firebase
                GeometryReader { geometry in
                    ScrollView(.horizontal) {
                        HStack(spacing: 10) {
                            ForEach(inventoryItemListViewModel.itemViewModels) { inventoryItemViewModel in
                                InventoryItemView(inventoryItemViewModel: inventoryItemViewModel)
                                    .padding([.leading, .trailing])
                                //                }
                            }
                        }
                    }
                }
                Spacer()
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
    InventoryItemListView(inventoryItemListViewModel: ItemListViewModel())
  }
}
