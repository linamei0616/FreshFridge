//
//  ContentView.swift
//  FreshFridge
//
//  Created by 41 Go Team on 10/19/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var itemListViewModel : ItemListViewModel
//    @Published var itemRepository = ItemRepository()
    var body: some View {
//       NavigationView {
//        Group {
//            List {
//                ForEach(itemListViewModel.itemViewModels) { item in
//
////                        NavigationLink {
////                            Text("Item at")
////                        } label: {
////                            Text(item.name) // retrieved from the model
////                        }
//                    ItemView(itemViewModel: item)
//                    }
//                }
//        }
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                EditButton()
//            }
//            ToolbarItem {
//                Button(action: addInventoryItem) {
//                    Label("Add Item", systemImage: "plus")
//                }
//            }
//        }
//    }
       InventoryItemListView(showForm: false)
}
    private func addInventoryItem() {
        /*
         To-Do:
         update this function to receive user inputs instead
         */
        let item = InventoryItem(id: "" , name: "banana", quantity: 2)
        itemListViewModel.add(item)
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
        let item = InventoryItem(name: "Banana", quantity: 5)
        let itemViewModel = ItemViewModel(item: item)
        let itemListViewModel = ItemListViewModel()
//        itemListViewModel.itemViewModels.append(itemViewModel)
//        itemListViewModel.itemViewModels = [itemViewModel]
//        ContentView(itemListViewModel: itemListViewModel)
        ContentView()
            .environmentObject(itemListViewModel)
    }
}
