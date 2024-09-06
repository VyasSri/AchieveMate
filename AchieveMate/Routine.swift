import Foundation
import SwiftData

enum ImportanceLevel: String {
    case Low, Medium, High
}

class Routine: Identifiable {
    var id: UUID
    var name: String
    var duration: Int
    var frequencyPerWeek: Int
    var specificDays: [String]
    var importanceLevel: ImportanceLevel

    init(id: UUID = UUID(), name: String, duration: Int, frequencyPerWeek: Int, specificDays: [String], importanceLevel: ImportanceLevel) {
        self.id = id
        self.name = name
        self.duration = duration
        self.frequencyPerWeek = frequencyPerWeek
        self.specificDays = specificDays
        self.importanceLevel = importanceLevel
    }
}
