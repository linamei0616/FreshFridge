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
        
    // 1
    @Published var itemViewModels: [ItemViewModel] = []
    // 2
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
      // 1
      itemRepository.$items.map { items in
//        items.map(ItemViewModel.init)
          items.map{ item in
              ItemViewModel(item: item)
//              var x = print(item.name)
          }
      }
      // 2
      .assign(to: \.itemViewModels, on: self)
      // 3
      .store(in: &cancellables)
    }
    
  // 4
    func add(_ item: InventoryItem) {
        itemRepository.add(item)
    }
    
}

