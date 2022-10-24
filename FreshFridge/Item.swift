//
//  Item.swift
//  FreshFridge
//
//  Created by Beatrice Alvares on 10/24/22.
//

import Foundation
import FirebaseFirestoreSwift

struct InventoryItem : Identifiable, Codable {
   @DocumentID var id: String?
    var name : String
}

