//
//  AlertInfo.swift
//  FreshFridge
//
//  Created by 41 Go Team on 12/2/22.
//

import Foundation
import UIKit

struct AlertInfo: Identifiable {

    enum AlertType {
        case one
        case two
    }
    let item: InventoryItem
    let id: AlertType
    let title: String
    let message: String
    

}

func alertInformation(name: String, quantity: Int, expirationDate: Int) -> String {
    return "Quantity: " + quantity.codingKey.stringValue + "\n Days Remaining: "  + String(expirationDate) + "\n" + "Tips: Freeze me!"
}

