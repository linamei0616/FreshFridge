//
//  ItemListViewModel.swift
//  FreshFridge
//
//  Created by Beatrice Alvares on 10/24/22.
//

import Foundation
import Combine

class ItemListViewModel: ObservableObject {
    @Published var itemRepository = ItemRepository()
    @Published var itemViewModels: [ItemViewModel] = []
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
      itemRepository.$items.map { items in
          items.map{ item in
              ItemViewModel(item: item)
          }
      }
      .assign(to: \.itemViewModels, on: self)
      .store(in: &cancellables)
    }
    
    func add(_ item: InventoryItem) {
        itemRepository.add(item)
    }
    func makenotification(_ item: InventoryItem) {
        itemRepository.makenotification(item)
    }
    
    func remove(at offsets: IndexSet){
        itemRepository.delete(at: offsets)
    }
    
    func removeItem(item: InventoryItem) {
        itemRepository.deleteItem(item: item)
    }
    
    
    func update(_ item: InventoryItem) {
        itemRepository.update(item)
    }
    func updatePoundsWasted(_ item: InventoryItem) {
        itemRepository.updatePoundsWasted(item)
    }
}

