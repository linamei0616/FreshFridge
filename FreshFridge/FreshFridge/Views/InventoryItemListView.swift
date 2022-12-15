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
    enum ActiveForm {
        case first
        case second
    }
    @State var showForm = false

    @State private var showingAlert = false
    @State private var info: AlertInfo?
    @State var showingDetail = false
    @State var showProfileView = false

    //MARK: - Variables - Search Bar

    @State var searchQuery = "" // Search Bar
    
    //MARK: - Colors
    let lightGrey = Color(red: 0.45, green: 0.57, blue: 0.72)
    let pastelBlue = Color(red: 0.77, green: 0.83, blue: 0.92)
    
    //MARK: - Body
    var body: some View {
        // did not recognize a user, users will need to sign in
        var display = inventoryItemListViewModel.itemViewModels
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
                        NavigationLink(
                                    destination: ProfileScreen(),
                                    isActive: $showProfileView
                                ) {
                                    EmptyView()
                                }.isDetailLink(false)
                        if #available(iOS 16.0, *) {
                            List {
                                ForEach(display) {
                                    result in
                                    Button(action: {
                                        info=AlertInfo(item: result.item, id: .one, title: result.item.name, message: alertInformation(name: result.item.name, quantity: result.item.quantity, expirationDate: ExpDates[result.item.name] ?? 10))
                                    }) {
                                        GroceryItemLabel(name: result.item.name, image: "", expirationDate: result.item.exp )
                                    }
                                    .foregroundColor(lightGrey)
                                    .alert(item: $info, content: { info in
                                        Alert(title: Text(info.title), message: Text(info.message), primaryButton: .destructive(Text("Edit")) {
                                            self.showingDetail.toggle()
                                            }, secondaryButton: .cancel())
                                        // make primaryButton : editscreen()
                                    })
                                }
                                .onDelete(perform: deleteItem)
                                .listRowSeparator(.hidden)
                                }
                            .searchable(text: $searchQuery)
                            .onSubmit(of: .search) {
                                if searchQuery.isEmpty {
                                } else {
                                    display = display.filter {
                                    $0.name
                                      .localizedCaseInsensitiveContains(searchQuery)
                                  }
                                }
                            }
                            .onChange(of: searchQuery) { _ in
                                if searchQuery.isEmpty {
                                } else {
                                    display = display.filter {
                                    $0.name
                                      .localizedCaseInsensitiveContains(searchQuery)
                                  }
                                }
                            }
                            .listStyle(.plain)
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
                    .navigationBarItems(leading:
                           Button(action: {
                               self.showProfileView = true
                           }) {
                               Image(systemName: "person.crop.circle")
                                   .font(.title)
                           }
                       )
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
