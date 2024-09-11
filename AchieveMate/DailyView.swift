import SwiftUI
import SwiftData

struct DailyView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var currentUser: User? // Store the current user
    @State private var todaysRoutines: [Routine] = [] // Store routines for today
    @State private var totalPoints: Int = 0
    @State private var completedRoutines: Set<UUID> = [] // Track completed routines
    @State private var confirmationMessage: String? = nil // Message for points added

    let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

    var body: some View {
        NavigationView {
            VStack {
                // Display the total points for the user
                if let user = currentUser {
                    Text("Total Points: \(user.points)")
                        .font(.headline)
                        .padding(.top, 20)
                }

                // Display the current day of the week
                Text("Today is \(getCurrentDayOfWeek())")
                    .font(.largeTitle)
                    .padding(.top, 20)

                // Show a confirmation message when a routine is completed
                if let message = confirmationMessage {
                    Text(message)
                        .font(.subheadline)
                        .foregroundColor(.green)
                        .padding()
                }

                // If there are no routines for today, show a message
                if todaysRoutines.isEmpty {
                    Text("You have no scheduled routines today! Enjoy the day off!")
                        .font(.subheadline)
                        .padding()
                } else {
                    // Checklist of today's routines
                    List {
                        ForEach(todaysRoutines) { routine in
                            HStack {
                                Text(routine.name)
                                    .font(.headline)
                                Spacer()
                                Button(action: {
                                    markRoutineCompleted(routine: routine)
                                }) {
                                    Text(routine.isCompleted ? "Completed" : "Mark Complete")
                                        .padding()
                                        .background(routine.isCompleted ? Color.gray : Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                                .disabled(routine.isCompleted) // Disable button if completed
                            }
                        }
                    }
                }

                Spacer()

                // Week Plan button to navigate to the WeekPlanView
                NavigationLink(destination: WeekPlanView(currentUser: currentUser)) {
                    Text("Week Plan")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.bottom, 20)
            }
            .onAppear {
                loadCurrentUser()
                loadTodaysRoutines()
            }
            .navigationBarTitle("Daily View", displayMode: .inline) // Ensures this is a separate screen
        }
    }

    // Function to get the current day of the week
    private func getCurrentDayOfWeek() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: Date())
    }

    // Load routines for the current day of the week
    private func loadTodaysRoutines() {
        guard let user = currentUser else { return }
        let currentDay = getCurrentDayOfWeek()

        // Filter routines for the current day
        todaysRoutines = user.routines.filter { $0.specificDays.contains(currentDay) }
    }

    // Mark a routine as completed, gray out the button, and show a message
    private func markRoutineCompleted(routine: Routine) {
        guard let user = currentUser else { return }

        // Check if the routine is already completed
        if routine.isCompleted {
            return // Exit if the routine is already completed
        }

        // Add points based on the routine's importance level
        var pointsAdded = 0
        switch routine.importanceLevel {
        case .Low:
            pointsAdded = 5
            user.points += 5
        case .Medium:
            pointsAdded = 10
            user.points += 10
        case .High:
            pointsAdded = 20
            user.points += 20
        }

        // Mark the routine as completed
        routine.isCompleted = true

        // Add the routine to the set of completed routines
        completedRoutines.insert(routine.id)

        // Save the user's updated points and routine completion state
        saveUserPointsAndRoutine(user: user)

        // Reload total points
        totalPoints = user.points

        // Show confirmation message
        confirmationMessage = "Good job, \(pointsAdded) points were added to your weekly score!"
        
        // Automatically hide the confirmation message after a few seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            confirmationMessage = nil
        }
    }

    // Save the updated points for the user and the routine's completion state
    private func saveUserPointsAndRoutine(user: User) {
        do {
            try modelContext.save() // Save both user points and the routine's isCompleted state
        } catch {
            print("Error saving user points or routine completion state: \(error)")
        }
    }

    // Load the current user based on the stored userId
    private func loadCurrentUser() {
        if let userIdString = UserDefaults.standard.string(forKey: "userId"),
           let userId = UUID(uuidString: userIdString) {
            do {
                let users = try modelContext.fetch(FetchDescriptor<User>())
                if let user = users.first(where: { $0.id == userId }) {
                    currentUser = user
                    totalPoints = user.points
                }
            } catch {
                print("Error fetching user: \(error)")
            }
        }
    }
}
