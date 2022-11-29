//
//  ItemView.swift
//  FreshFridge
//
//  Created by 41 Go Team on 11/21/22.
//

import SwiftUI

struct ItemView: View {
    @State var itemViewModel: ItemViewModel
    var body: some View {
        HStack {
            Text(itemViewModel.item.name)
              //  .foregroundColor(Color.black)
        }
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(itemViewModel: ItemViewModel(item: InventoryItem(name: "banana", quantity: 2)))


    }
}
