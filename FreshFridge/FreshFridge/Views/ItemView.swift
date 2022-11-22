//
//  ItemView.swift
//  FreshFridge
//
//  Created by 41 Go Team on 11/21/22.
//

import SwiftUI

struct ItemView: View {
    @ObservedObject var itemViewModel: ItemViewModel
    var body: some View {
        HStack {
            Text(itemViewModel.name)
                .foregroundColor(Color.black)
        }
    }
}

//struct ItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemView(itemViewModel: ItemViewModel(item: InventoryItem(name: "banana", quantity: 2)), body: some View)
//
//
//    }
//}
