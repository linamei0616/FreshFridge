//
//  Profile.swift
//  FreshFridge
//
//  Created by Beatrice Alvares on 12/14/22.
//

import Foundation

struct Profile {
    var username: String
    var prefersNotifications = true
    var seasonalPhoto = Season.winter
    var goalDate = Date()

    enum Season: String, CaseIterable, Identifiable {
        case spring = "🌷"
        case summer = "🌞"
        case autumn = "🍂"
        case winter = "☃️"

        var id: String { rawValue }
    }
    
    mutating func setName(name: String) {
        username = name

    }
}
