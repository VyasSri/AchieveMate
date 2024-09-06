import SwiftUI
import SwiftData

@main
struct AchieveMateApp: App {
    // Initialize the model container
    var modelContainer: ModelContainer

    init() {
        // Create the model container with the `User` model
        modelContainer = try! ModelContainer(for: User.self)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(modelContainer) // Inject the model container into the environment
        }
    }
}
