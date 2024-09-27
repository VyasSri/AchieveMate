import SwiftUI
import SwiftData

struct RoutinesView: View {
    @Binding var isAuthenticated: Bool
    @State private var showingAddRoutineView = false
    @State private var selectedRoutine: Routine? // Routine being edited or added
    @Environment(\.modelContext) private var modelContext // Access the SwiftData context
    @State private var currentUser: User? // Store the current user

    var body: some View {
        NavigationView {
            VStack {
                Text("Add Routines Here")
                    .font(.largeTitle)
                    .padding(.top, 20)

                if let user = currentUser {
                    Text("Hello, \(user.name)")
                        .font(.subheadline)
                        .padding(.bottom, 20)

                    if user.routines.isEmpty {
                        Text("No routines yet")
                    } else {
                        List {
                            ForEach(user.routines) { routine in
                                VStack(alignment: .leading) {
                                    Text(routine.name)
                                        .font(.headline)
                                    Text("Importance: \(routine.importanceLevel.rawValue)")
                                        .font(.subheadline)
                                    Text("Days: \(routine.specificDays.joined(separator: ", "))")
                                        .font(.subheadline)
                                }
                                .onTapGesture {
                                    self.selectedRoutine = routine
                                    self.showingAddRoutineView = true
                                }
                            }
                            .onDelete(perform: deleteRoutine)
                        }
                    }
                } else {
                    Text("Loading user data...")
                        .font(.subheadline)
                        .padding(.bottom, 20)
                }

                Spacer()

                // "Next" button to navigate to the DailyView at the bottom
                NavigationLink(destination: DailyView()) {
                    Text("View Today's Routines")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.bottom, 20)
            }
            .navigationBarItems(
                trailing: Button(action: {
                    self.selectedRoutine = nil
                    self.showingAddRoutineView = true
                }) {
                    Image(systemName: "plus")
                        .imageScale(.large)
                }
            )
            .sheet(isPresented: $showingAddRoutineView) {
                AddEditRoutineView(currentUser: $currentUser, routine: $selectedRoutine, isPresented: $showingAddRoutineView)
            }
            .onAppear {
                loadCurrentUser() // Fetch the current user and authenticate
            }
        }
    }

    // Load the current user based on the stored userId and authenticate
    private func loadCurrentUser() {
        if let userIdString = UserDefaults.standard.string(forKey: "userId"),
           let userId = UUID(uuidString: userIdString) {
            do {
                let users = try modelContext.fetch(FetchDescriptor<User>())
                if let user = users.first(where: { $0.id == userId }) {
                    currentUser = user
                    isAuthenticated = true // Authenticate if the user is found
                } else {
                    print("User not found.")
                    isAuthenticated = false
                }
            } catch {
                print("Error fetching user: \(error)")
                isAuthenticated = false
            }
        } else {
            print("No userId found in UserDefaults.")
            isAuthenticated = false
        }
    }

    func deleteRoutine(at offsets: IndexSet) {
        currentUser?.routines.remove(atOffsets: offsets)
        saveUserRoutines()
    }

    private func saveUserRoutines() {
        do {
            try modelContext.save() // Save updated user routines
        } catch {
            print("Error saving routines: \(error)")
        }
    }
}
