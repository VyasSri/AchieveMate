import SwiftUI
import SwiftData

@main
struct AchieveMateApp: App {
    // Initialize the model container
    var body: some Scene {
        WindowGroup {
            ContentView()
            .modelContainer(for: [User.self, Routine.self])
        }
    }
}
