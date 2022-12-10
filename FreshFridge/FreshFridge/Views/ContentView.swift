//
//  ContentView.swift
//  FreshFridge
//
//  Created by 41 Go Team on 10/19/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var itemListViewModel : ItemListViewModel
    @EnvironmentObject var signupVM : SignUpViewModel // google SignUp
//    @Published var itemRepository = ItemRepository()
    var body: some View {
        if (signupVM.isLogin == false) {
            LoginScreen()
        } else {
            InventoryItemListView(showForm: false)
                .onAppear{
                    UNUserNotificationCenter.current().requestAuthorization(options:[.alert, .badge, .sound]) { success, error in
                        if success {
                            print(success)
                            
                        }
                        else if let error = error{
                            print(error.localizedDescription)
                        }
                    }
                }
        }
    }

}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        let item = InventoryItem(name: "Banana", quantity: 5)
//        let itemViewModel = ItemViewModel(item: item)
        let itemListViewModel = ItemListViewModel()
//        itemListViewModel.itemViewModels.append(itemViewModel)
//        itemListViewModel.itemViewModels = [itemViewModel]
//        ContentView(itemListViewModel: itemListViewModel)
        ContentView()
            .environmentObject(itemListViewModel)
    }
}
