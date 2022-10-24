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

  // 5
  func add(_ item: InventoryItem) {
    do {
      // 6
      _ = try store.collection(path).addDocument(from: item)
    } catch {
      fatalError("Unable to add card: \(error.localizedDescription).")
    }
  }
}

