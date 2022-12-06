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
    
    //MARK: - Variables - Firebase data
    @EnvironmentObject var inventoryItemListViewModel : ItemListViewModel // firebase model
    var inventoryItemViewModel: ItemViewModel? = nil

    //MARK: - Variables - Alerts
    @State var showForm = false
    @State private var showingAlert = false
    @State private var info: AlertInfo?

    @State var search = "" // Search Bar
    @State private var quant: String = ""

    
    //MARK: - Colors
    let lightGrey = Color(red: 0.45, green: 0.57, blue: 0.72)
    let pastelBlue = Color(red: 0.77, green: 0.83, blue: 0.92)
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                if #available(iOS 16.0, *) {
                    List {
                        ForEach(inventoryItemListViewModel.itemViewModels) {
                            result in
                            //                                Text(result.item.name)
                            Button(action: {
                                info=AlertInfo(item: result.item, id: .one, title: result.item.name, message: alertInformation(name: result.item.name, quantity: result.item.quantity, expirationDate: ExpDates[result.item.name] ?? 10))
                            }) {
                                GroceryItemLabel(name: result.item.name, image: "", expirationDate: ExpDates[result.item.name] ?? 10)
                            }
                            .foregroundColor(lightGrey)
                            .alert(item: $info, content: {info in
                                Alert(title: Text(info.title), message: Text(info.message), primaryButton: .destructive(Text("Edit")), secondaryButton: .cancel())
                                
                            })
                        }
                        .onDelete(perform: deleteItem)
                        ////                            .onMove(perform: move)
                        //                            .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always))
                    }
                    .scrollContentBackground(.hidden)
                } else {
                    // Fallback on earlier versions
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
            .toolbar{
                EditButton()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
    
    //MARK: - Firebase functs
    func deleteItem(at indexes:IndexSet) {
                inventoryItemListViewModel.remove(at: indexes)
        }
}

struct InventoryItemListView_Previews: PreviewProvider {
  static var previews: some View {
      InventoryItemListView()
          .environmentObject(ItemListViewModel())
  }
}
