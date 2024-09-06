import SwiftUI
import SwiftData

struct RoutinesView: View {
    @Binding var isAuthenticated: Bool
    @State private var routines: [Routine] = [] // Manage list of routines
    @State private var showingAddRoutineView = false // Control add/edit routine view
    @State private var selectedRoutine: Routine? // Routine being edited or added
    @Environment(\.modelContext) private var modelContext // Access the SwiftData context
    @State private var currentUser: User? // Store the current user

    var body: some View {
        NavigationView {
            VStack {
                Text("Add Routines Here")
                    .font(.largeTitle)
                    .padding(.top, 20)

                // Display the username
                if let user = currentUser {
                    Text("Hello, \(user.name)")
                        .font(.subheadline)
                        .padding(.bottom, 20)
                } else {
                    Text("Loading user data...")
                        .font(.subheadline)
                        .padding(.bottom, 20)
                }

                // List of routines
                List {
                    ForEach(routines) { routine in
                        VStack(alignment: .leading) {
                            Text(routine.name)
                                .font(.headline)
                            Text("Duration: \(routine.duration) min, Frequency: \(routine.frequencyPerWeek) times/week")
                                .font(.subheadline)
                            Text("Importance: \(routine.importanceLevel.rawValue)")
                                .font(.subheadline)
                            Text("Days: \(routine.specificDays.joined(separator: ", "))")
                                .font(.subheadline)
                        }
                        .onTapGesture {
                            self.selectedRoutine = routine // Edit selected routine
                            self.showingAddRoutineView = true
                        }
                    }
                    .onDelete(perform: deleteRoutine) // For swipe-to-delete functionality
                }
                .listStyle(PlainListStyle())

                Spacer()
            }
            .navigationBarItems(
                leading: Button(action: {
                    logout() // Logout function
                }) {
                    Text("Logout")
                        .foregroundColor(.red) // Added color for logout button
                },
                trailing: Button(action: {
                    self.selectedRoutine = nil // Clear selected routine to add new one
                    self.showingAddRoutineView = true
                }) {
                    Image(systemName: "plus")
                        .imageScale(.large)
                }
            )
            .sheet(isPresented: $showingAddRoutineView) {
                AddEditRoutineView(routines: $routines, routine: $selectedRoutine, isPresented: $showingAddRoutineView)
            }
            .onAppear {
                loadCurrentUser() // Fetch the current user
            }
        }
    }

    // Load the current user from SwiftData using the saved userId from UserDefaults
    private func loadCurrentUser() {
        if let userIdString = UserDefaults.standard.string(forKey: "userId"),
           let userId = UUID(uuidString: userIdString) {
            do {
                // Manually fetch the user from modelContext
                let users = try modelContext.fetch(FetchDescriptor<User>())
                if let user = users.first(where: { $0.id == userId }) {
                    currentUser = user
                } else {
                    print("User not found.")
                }
            } catch {
                print("Error fetching user: \(error)")
            }
        } else {
            print("No userId found in UserDefaults.")
        }
    }

    // Logout function
    private func logout() {
        UserDefaults.standard.removeObject(forKey: "userId")
        isAuthenticated = false
    }

    // Delete routine
    func deleteRoutine(at offsets: IndexSet) {
        routines.remove(atOffsets: offsets)
    }
}

struct RoutinesView_Previews: PreviewProvider {
    static var previews: some View {
        RoutinesView(isAuthenticated: .constant(true))
    }
}
