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
    @State private var info: AlertInfo?
    @State private var quant: String = ""

    
    //MARK: - Colors
    let lightGrey = Color(red: 0.45, green: 0.57, blue: 0.72)
    let pastelBlue = Color(red: 0.77, green: 0.83, blue: 0.92)
    
    //MARK: - Firebase functs
//    func deleteItems() {
//        let item = InventoryItem(name: "banana" , quantity: 5 )
//        inventoryItemListViewModel.remove(item)
//    }
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                //MARK: - Firebase
                GeometryReader { geometry in
                    ScrollView(.vertical) {
                        VStack() {
                            ForEach(inventoryItemListViewModel.itemViewModels) {
                                result in Button(action: {
                                    info=AlertInfo(item: result.item, id: .one, title: result.item.name, message: alertInformation(name: result.item.name, quantity: result.item.quantity, expirationDate: ExpDates[result.item.name] ?? 10))
                                }) {
                                        GroceryItemLabel(name: result.item.name, image: "", expirationDate: ExpDates[result.item.name] ?? 10)
                                    }
                                    .foregroundColor(lightGrey)
                                    .alert(item: $info, content: { info in
                                        Alert(title: Text(info.title), message: Text(info.message), primaryButton: .destructive(Text("Edit")), secondaryButton: .cancel())
                                    })
                                    
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
