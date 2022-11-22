//
//  ItemRepository.swift
//  FreshFridge
//
//  Created by Beatrice Alvares on 10/24/22.
//

// 1
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

// 2
class ItemRepository: ObservableObject {
  // 3
  private let path: String = "item"
  // 4
  private let store = Firestore.firestore()
    
    // 1
    @Published var items: [InventoryItem] = []

    // 2
    init() {
      get()
    }

    func get() {
      // 3
      store.collection(path)
        .addSnapshotListener { querySnapshot, error in
          // 4
          if let error = error {
            print("Error getting items: \(error.localizedDescription)")
            return
          }
          // 5
          self.items = querySnapshot?.documents.compactMap { document in
            // 6
              try? document.data(as: InventoryItem.self)
          } ?? []
        }
    }

  // 5
  func add(_ item: InventoryItem) {
    do {
      // 6
      _ = try store.collection(path).addDocument(from: item)
    } catch {
      fatalError("Unable to add item: \(error.localizedDescription).")
    }
  }
    
    func remove(_ item: InventoryItem) {
      // 1
      guard let itemId = item.id else { return }

      // 2
      store.collection(path).document(itemId).delete { error in
        if let error = error {
          print("Unable to remove inventoryItem: \(error.localizedDescription)")
        }
      }
    }
    func update(_ item: InventoryItem) {
        guard let id = item.id else { return }
        do {
            try store.collection(path).document(id).setData(from: item)
        } catch  {
            fatalError("Unable to update item:  \(error.localizedDescription)")
        }
    }
}

