//
//  GroceryItem.swift
//  GroceryApp
//
//  Created by ECC Chicago on 11/7/22.
//

import Foundation
import SwiftUI

struct GroceryItem: Identifiable {
    var id = UUID()
    let name: String
    let quantity: Int
    let image: String
   // let weight: String
    let color: Color
    //let plunumber: String
    let description: String
   
    
    static func getFruits()->[GroceryItem]{
        return [
            GroceryItem(name: "Apple",
                        quantity: 10,
                        image: "apple",
                        color: .green,
                        description: "An apple is an edible fruit produced by an apple tree. Apple trees are cultivated worldwide and are the most widely grown species in the genus Malus. The tree originated in Central Asia, where its wild ancestor, Malus sieversii, is still found today."),
            GroceryItem(name: "Mango",
                        quantity: 20,
                        image: "mango",
                        color: .blue,
                        description: "A mango is an edible stone fruit produced by the tropical tree Mangifera indica which is believed to have originated from the region between northwestern Myanmar, Bangladesh, and northeastern India."),
            GroceryItem(name: "Watermelon",
                        quantity: 1,
                        image: "watermelon",
                        color: .red,
                        description: "Watermelon, (Citrullus lanatus), succulent fruit and vinelike plant of the gourd family (Cucurbitaceae), native to tropical Africa and cultivated around the world. The fruit contains vitamin A and some vitamin C and is usually eaten raw. The rind is sometimes preserved as a pickle. watermelon.")
        ]
    }
}
