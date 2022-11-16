//
//  ContentView.swift
//  FreshFridge
//
//  Created by 41 Go Team on 10/19/22.
//

import SwiftUI
import CoreData


struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var itemListViewModel : ItemListViewModel
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)

    var body: some View {
       NavigationView {
        Group {
            List {
                ForEach(itemListViewModel.itemViewModels) { item in
                        NavigationLink {
                            Text("Item at")
                        } label: {
                            Text(item.id)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }

        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button(action: addInventoryItem) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
    }
}

    private func addItem() {
        withAnimation {
//            print(itemListViewModel.$itemViewModels.count())
            
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    private func addInventoryItem() {
        let item = InventoryItem(id: "" , name: "banana")
        itemListViewModel.add(item)
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
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
        ContentView(itemListViewModel: ItemListViewModel()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
