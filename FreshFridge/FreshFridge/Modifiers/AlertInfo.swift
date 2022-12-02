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



// trying to make the edit button work
func showAlert() {
    let alert = UIAlertController(title: "Some Title", message: "Enter a text", preferredStyle: .alert)
    alert.addTextField {
        field in field.placeholder = "Email Address"
    }
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//        var username: String = ""
    
}

class NewAlertInfo {
//
//    enum AlertType {
//        case one
//        case two
//    }
//    let item: InventoryItem
//    let id: AlertType
//    let title: String
//    @State var newMessage: String
    @objc func showAlert() {
        let alert = UIAlertController(title: "Some Title", message: "Enter a text", preferredStyle: .alert)
        alert.addTextField {
            field in field.placeholder = "Email Address"
        }
//        var username: String = ""
        
    }
}
