//
//  ItemViewModel.swift
//  FreshFridge
//
//  Created by 41 Go Team on 11/14/22.
//

import Combine

// 1
class ItemViewModel: ObservableObject, Identifiable {
    // 2
    private let itemRepository = ItemRepository()
    @Published var item: InventoryItem
    // 3
    private var cancellables: Set<AnyCancellable> = []
    // 4
    var id = "" // need to add all variables here as well
    var name = ""
    var quantity = 0
    var exp = 0

    init(item: InventoryItem) {
        self.item = item
        // 5
        $item
        .compactMap { $0.id }
        .assign(to: \.id, on: self)
        .store(in: &cancellables)
    }
//    func update() {
//        itemRepository.update(item)
//    }
}

