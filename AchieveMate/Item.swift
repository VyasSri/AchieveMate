//
//  Item.swift
//  AchieveMate
//
//  Created by Vyas Sriman on 9/3/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}


@Model
class User {
    var id: UUID
    var name: String
    var email: String
    var password: String
    
    init(id: UUID = UUID(), name: String, email: String, password: String) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
    }
}

