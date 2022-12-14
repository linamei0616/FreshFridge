//
//  InventoryItem.swift
//  FreshFridge
//
//  Created by 41 Go Team on 11/16/22.
//

import Foundation
import FirebaseFirestoreSwift

struct InventoryItem : Identifiable, Codable {
   @DocumentID var id: String?
    var name : String
    var quantity : Int
    var exp: Int
}
