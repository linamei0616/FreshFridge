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
import UserNotifications
import FirebaseAuth
import Firebase
// 2
class ItemRepository: ObservableObject {
  // 3
    
//    private let userID = Auth.auth().currentUser?.uid
//    @State private var auth = Firebase.Auth.auth()
    private var path: String = Auth.auth().currentUser?.uid ?? "Unknown User"
    // 4
    private let store = Firestore.firestore()

    // 1
    @Published var items: [InventoryItem] = []

    // 2
    init() {
        get()
        items = items.sorted(by: {$0.exp < $1.exp})
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
    
    func makenotification(_ item: InventoryItem){
        let content = UNMutableNotificationContent()
        content.title = " \(item.name) About to Expire"
        content.subtitle = "this will expire in 5 days!"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(ExpDates[item.name] ?? 10), repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func delete(at offsets: IndexSet) {
      offsets.map { items[$0] }.forEach { item in
        guard let itemID = item.id else { return }
        store.collection(path).document(itemID).delete() { err in
          if let err = err {
            print("Error removing document: \(err)")
          } else {
            print("Document successfully removed!")
          }
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

