import SwiftUI
import SwiftData

struct WeekPlanView: View {
    var currentUser: User?

    let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

    var body: some View {
        VStack {
            Text("Week Plan")
                .font(.largeTitle)
                .padding()

            // If there are no routines, show a message
            if let user = currentUser, user.routines.isEmpty {
                Text("No routines scheduled for this week.")
                    .font(.subheadline)
                    .padding()
            } else {
                // Calendar-style view for the week
                List {
                    ForEach(daysOfWeek, id: \.self) { day in
                        Section(header: Text(day).font(.headline)) {
                            if let user = currentUser {
                                let routinesForDay = user.routines.filter { $0.specificDays.contains(day) }
                                
                                if routinesForDay.isEmpty {
                                    Text("No routines for \(day)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                } else {
                                    ForEach(routinesForDay) { routine in
                                        Text(routine.name)
                                            .font(.subheadline)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Week Plan", displayMode: .inline) // Ensure this is a separate screen
    }
}

struct WeekPlanView_Previews: PreviewProvider {
    static var previews: some View {
        WeekPlanView(currentUser: nil)
    }
}
