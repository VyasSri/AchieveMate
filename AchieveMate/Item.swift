import Foundation
import SwiftData

@Model
class User: Identifiable {
    var id: UUID
    var name: String
    var email: String
    var password: String
    var routines: [Routine] // User's routines

    init(id: UUID = UUID(), name: String, email: String, password: String, routines: [Routine] = []) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.routines = routines
    }
}

