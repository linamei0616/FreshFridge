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
    @EnvironmentObject var signupVM : SignUpViewModel // google SignUp
    @State private var auth = Auth.auth()
    
    //MARK: - Variables - Alerts
    @State var showForm = false
    @State private var showingAlert = false
    @State private var info: AlertInfo?

    //MARK: - Variables - Search Bar

    @State var query = "" // Search Bar
    @State private var quant: String = ""
    
    //MARK: - Colors
    let lightGrey = Color(red: 0.45, green: 0.57, blue: 0.72)
    let pastelBlue = Color(red: 0.77, green: 0.83, blue: 0.92)
    
    //MARK: - Body
    var body: some View {
        // did not recognize a user, users will need to sign in
        if (Auth.auth().currentUser == nil) {
            Button {
                signupVM.signUpWithGoogle()
            } label: {
                Text("Sign in with google")
                }
            } else {
                // recognized user, leads to home page
                NavigationView {
                    VStack {
                        if #available(iOS 16.0, *) {
                            List {
                                ForEach(inventoryItemListViewModel.itemViewModels) {
                                    result in
                                    Button(action: {
                                        print("traversing list")
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
                                //                        .searchable(text: $query) {
                                //                            ForEach(inventoryItemListViewModel.itemViewModels., id: \.self) { suggestion in
                                //                                Text(suggestion)
                                //                                    .searchCompletion(suggestion)
                                //                            }
                                //                        }
                                //                        .onChange(of: query) { newQuery in
                                //                            async { await inventoryItemListViewModel.search(matching: query)}
                                //                        }
                                
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
