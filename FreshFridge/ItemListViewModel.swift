//
//  ItemListViewModel.swift
//  FreshFridge
//
//  Created by Beatrice Alvares on 10/24/22.
//

import Foundation
import Combine

// 2
class ItemListViewModel: ObservableObject {
  // 3
  @Published var itemRepository = ItemRepository()

  // 4
  func add(_ item: InventoryItem) {
    itemRepository.add(item)
  }
}

