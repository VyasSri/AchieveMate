//
//  DailyView.swift
//  AchieveMate
//
//  Created by Vyas Sriman on 9/7/24.
//

import Foundation
import SwiftUI
import SwiftData

struct DailyView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var currentUser: User? // Store the current user
    @State private var todaysRoutines: [Routine] = [] // Store routines for today
    @State private var totalPointsForToday: Int = 0

    let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

    var body: some View {
        NavigationView {
            VStack {
                Text("Today is \(getCurrentDayOfWeek())")
                    .font(.largeTitle)
                    .padding(.top, 20)

                if todaysRoutines.isEmpty {
                    Text("You have no scheduled routines today! Enjoy the day off!")
                        .font(.subheadline)
                        .padding()
                } else {
                    List {
                        ForEach(todaysRoutines) { routine in
                            HStack {
                                Text(routine.name)
                                    .font(.headline)
                                Spacer()
                                Button(action: {
                                    markRoutineCompleted(routine: routine)
                                }) {
                                    Image(systemName: "checkmark.square")
                                }
                            }
                        }
                    }
                }

                Spacer()

                // Display total points for today
                Text("Today's Points: \(totalPointsForToday)")
                    .font(.headline)
                    .padding()

                Spacer()
            }
            .onAppear {
                loadCurrentUser()
                loadTodaysRoutines()
            }
        }
    }

    private func getCurrentDayOfWeek() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: Date())
    }

    private func loadTodaysRoutines() {
        guard let user = currentUser else { return }
        let currentDay = getCurrentDayOfWeek()

        todaysRoutines = user.routines.filter { $0.specificDays.contains(currentDay) }
    }

    private func markRoutineCompleted(routine: Routine) {
        guard let user = currentUser else { return }

        // Add points based on routine importance
        switch routine.importanceLevel {
        case .Low:
            user.points += 5
        case .Medium:
            user.points += 10
        case .High:
            user.points += 20
        }

        // Update total points for today
        totalPointsForToday = user.points

        // Save changes
        do {
            try modelContext.save()
        } catch {
            print("Error saving points: \(error)")
        }
    }

    private func loadCurrentUser() {
        if let userIdString = UserDefaults.standard.string(forKey: "userId"),
           let userId = UUID(uuidString: userIdString) {
            do {
                let users = try modelContext.fetch(FetchDescriptor<User>())
                if let user = users.first(where: { $0.id == userId }) {
                    currentUser = user
                    totalPointsForToday = user.points
                }
            } catch {
                print("Error fetching user: \(error)")
            }
        }
    }
}

struct DailyView_Previews: PreviewProvider {
    static var previews: some View {
        DailyView()
    }
}
