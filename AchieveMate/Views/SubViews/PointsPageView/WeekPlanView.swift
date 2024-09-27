import SwiftUI
import SwiftData

struct WeekPlanView: View {
    var currentUser: User?
    @Environment(\.presentationMode) var presentationMode // To control the dismissal of the sheet

    let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    let columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)

    var body: some View {
        VStack {
            // Custom Back Button to dismiss the popup
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss() // Dismiss the popup
                }) {
                    Text("Back")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding()
                }
                Spacer()
            }
            .padding(.leading)

            // Title for Week Plan
            Text("Week Plan")
                .font(.largeTitle)
                .padding()

            // LazyVGrid for displaying routines in a calendar-like view
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(daysOfWeek, id: \.self) { day in
                    VStack(alignment: .leading) {
                        Text(day)
                            .font(.headline)
                            .padding(.bottom, 5)
                        
                        if let user = currentUser {
                            let routinesForDay = user.routines.filter { $0.specificDays.contains(day) }
                            
                            if routinesForDay.isEmpty {
                                Text("No routines")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            } else {
                                ForEach(routinesForDay) { routine in
                                    Text(routine.name)
                                        .font(.subheadline)
                                        .padding(3)
                                }
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .shadow(radius: 3)
                }
            }
            .padding()

            Spacer()
        }
    }
}

struct WeekPlanView_Previews: PreviewProvider {
    static var previews: some View {
        WeekPlanView(currentUser: nil)
    }
}
