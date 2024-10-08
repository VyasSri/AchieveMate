import Foundation
import SwiftData

enum ImportanceLevel: String, Codable {
    case Low, Medium, High
}

@Model
class Routine: Identifiable {
    var id: UUID
    var name: String
    var duration: Int
    var specificDays: [String]
    var importanceLevelRawValue: String // Store raw value instead of enum
    var isCompleted: Bool = false // New flag to track completion

    // Computed property to get/set the enum
    var importanceLevel: ImportanceLevel {
        get {
            ImportanceLevel(rawValue: importanceLevelRawValue) ?? .Medium
        }
        set {
            importanceLevelRawValue = newValue.rawValue
        }
    }

    init(id: UUID = UUID(), name: String, duration: Int, specificDays: [String], importanceLevel: ImportanceLevel) {
        self.id = id
        self.name = name
        self.duration = duration
        self.specificDays = specificDays
        self.importanceLevelRawValue = importanceLevel.rawValue
        self.isCompleted = false // Default is not completed
    }
}
