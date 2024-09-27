import Foundation
import SwiftData

@Model
class User: Identifiable {
    var id: UUID
    var name: String
    var email: String
    var password: String
    var routines: [Routine] // User's routines
    var points: Int
    var new: Bool

    init(id: UUID = UUID(), name: String, email: String, password: String, routines: [Routine] = [], points: Int = 0, new: Bool = true) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.routines = routines
        self.points = points
        self.new = new
    }
    // returns the user's ID
    func getId() -> UUID{
        return id
    }
    // returns the user's name
    func getName() -> String{
        return name
    }
    // returns the user's email
    func getEmail() -> String{
        return email
    }
    // returns the user's password
    func getPassword() -> String{
        return password
    }
    // returns the user's routines
    func getRoutines() -> [Routine]{
        return routines
    }
    //returns the amount of points the user has
    func getPoints() ->Int{
        return points
    }
    //returns if the user is new
    func getNew() -> Bool{
        return new
    }
}

