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

class ItemRepository: ObservableObject {

    private var path: String = Auth.auth().currentUser?.uid ?? "Unknown User"
    private let store = Firestore.firestore()

    @Published var items: [InventoryItem] = []


    init() {
        get()
    }
    
//MARK: Retrieving from firebase
    func get() {
      store.collection(path)
        .addSnapshotListener { querySnapshot, error in
          if let error = error {
            print("Error getting items: \(error.localizedDescription)")
            return
          }
            self.items = querySnapshot?.documents.compactMap { document in
              try? document.data(as: InventoryItem.self)
            } ?? []
            //
            self.items = self.items.sorted(by: { $0.exp < $1.exp })
        }

    }
    
//MARK: Adding to firebase
  func add(_ item: InventoryItem) {
    do {
      _ = try store.collection(path).addDocument(from: item)
    } catch {
      fatalError("Unable to add item: \(error.localizedDescription).")
    }
  }
    
//MARK: Notification for items
    func makenotification(_ item: InventoryItem){
        let content = UNMutableNotificationContent()
        content.title = " \(item.name) About to Expire"
        content.subtitle = "this will expire in 5 days!"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(ExpDates[item.name] ?? 10), repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
//MARK: Deleting from firebase
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
    
//MARK: Updating firebase
    func update(_ item: InventoryItem) {
        guard let id = item.id else { return }
        do {
            try store.collection(path).document(id).setData(from: item)
        } catch  {
            fatalError("Unable to update item:  \(error.localizedDescription)")
        }
    }
}

