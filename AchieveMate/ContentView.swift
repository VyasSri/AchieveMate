import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var isAuthenticated: Bool = false
    @Environment(\.modelContext) private var modelContext
    @State private var currentUser: User? // To hold the authenticated user's data

    var body: some View {
        Group {
            if isAuthenticated {
                AppTabView(isAuthenticated: $isAuthenticated)
            } else {
                AuthView(isAuthenticated: $isAuthenticated)
            }
        }
        .onAppear {
            checkIfAuthenticated()
        }
    }

    // Function to check if user is authenticated using SwiftData
    private func checkIfAuthenticated() {
        let storedUserId = UserDefaults.standard.string(forKey: "userId")

        if let userIdString = storedUserId, let userId = UUID(uuidString: userIdString) {
            currentUser = fetchUser(withId: userId, context: modelContext)

            if currentUser != nil {
                isAuthenticated = true
            } else {
                isAuthenticated = false
            }
        } else {
            isAuthenticated = false
        }
    }
    
    // Fetch User from SwiftData using the provided userId
    private func fetchUser(withId id: UUID, context: ModelContext) -> User? {
        let fetchRequest = FetchDescriptor<User>(predicate: #Predicate { $0.id == id })
        
        do {
            let result = try context.fetch(fetchRequest)
            return result.first
        } catch {
            print("Error fetching user: \(error)")
            return nil
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
