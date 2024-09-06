import SwiftUI

struct AddEditRoutineView: View {
    @Binding var routines: [Routine]
    @Binding var routine: Routine?
    @Binding var isPresented: Bool // Control if the add/edit routine panel is presented

    // Routine form fields
    @State private var name: String = ""
    @State private var duration: Double = 30 // Use a slider for duration
    @State private var frequencyPerWeek: Int = 1
    @State private var selectedDays: [Bool] = Array(repeating: false, count: 7) // Separate entity for each day (7 days)
    @State private var importanceLevel: String = "Medium" // Importance level

    let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Routine Information")) {
                    TextField("Routine Name", text: $name)

                    // Slider for routine duration (in minutes)
                    VStack {
                        Text("Duration: \(Int(duration)) minutes")
                        Slider(value: $duration, in: 1...120, step: 1)
                    }

                    // Stepper for frequency per week
                    Stepper(value: $frequencyPerWeek, in: 1...7) {
                        Text("Frequency: \(frequencyPerWeek) times per week")
                    }

                    // Individual checkboxes for days of the week
                    VStack(alignment: .leading) {
                        Text("Specific Days")
                        ForEach(0..<daysOfWeek.count, id: \.self) { index in
                            Toggle(isOn: $selectedDays[index]) {
                                Text(daysOfWeek[index])
                            }
                        }
                    }

                    // Importance level picker
                    Picker("Importance Level", selection: $importanceLevel) {
                        Text("Low").tag("Low")
                        Text("Medium").tag("Medium")
                        Text("High").tag("High")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                // Save button
                Button(action: saveRoutine) {
                    Text(routine == nil ? "Add Routine" : "Save Changes")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                // Delete button if editing
                if routine != nil {
                    Button(action: deleteRoutine) {
                        Text("Delete Routine")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                }
            }
            .navigationTitle(routine == nil ? "Add Routine" : "Edit Routine")
            .navigationBarItems(
                leading: Button(action: {
                    isPresented = false // Collapse the panel when back is pressed
                }) {
                    Text("Back")
                        .foregroundColor(.blue)
                }
            )
            .onAppear {
                if let routine = routine {
                    name = routine.name
                    duration = Double(routine.duration)
                    frequencyPerWeek = routine.frequencyPerWeek
                    selectedDays = daysOfWeek.map { routine.specificDays.contains($0) } // Set selected days
                    importanceLevel = routine.importanceLevel.rawValue
                }
            }
        }
    }

    // Save or edit the routine
    private func saveRoutine() {
        let selectedDaysArray = zip(daysOfWeek, selectedDays).compactMap { $1 ? $0 : nil }

        if let editingRoutine = routine {
            // Update existing routine
            if let index = routines.firstIndex(where: { $0.id == editingRoutine.id }) {
                routines[index] = Routine(id: editingRoutine.id, name: name, duration: Int(duration), frequencyPerWeek: frequencyPerWeek, specificDays: selectedDaysArray, importanceLevel: ImportanceLevel(rawValue: importanceLevel)!)
            }
        } else {
            // Add new routine
            let newRoutine = Routine(name: name, duration: Int(duration), frequencyPerWeek: frequencyPerWeek, specificDays: selectedDaysArray, importanceLevel: ImportanceLevel(rawValue: importanceLevel)!)
            routines.append(newRoutine)
        }

        // Collapse the panel when routine is saved
        isPresented = false
    }

    private func deleteRoutine() {
        if let editingRoutine = routine, let index = routines.firstIndex(where: { $0.id == editingRoutine.id }) {
            routines.remove(at: index)
        }

        // Collapse the panel after deletion
        isPresented = false
    }
}
