import SwiftUI
import SwiftData

struct AddEditRoutineView: View {
    @Binding var currentUser: User?
    @Binding var routine: Routine?
    @Binding var isPresented: Bool
    @Environment(\.modelContext) private var modelContext // Access the SwiftData context

    @State private var name: String = ""
    @State private var duration: Double = 30
    @State private var frequencyPerWeek: Int = 1
    @State private var selectedDays: [Bool] = Array(repeating: false, count: 7)
    @State private var importanceLevel: String = "Medium"
    @State private var showAlert = false
    @State private var alertMessage = ""

    let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Routine Information")) {
                    TextField("Routine Name", text: $name)
                    VStack {
                        Text("Duration: \(Int(duration)) minutes")
                        Slider(value: $duration, in: 1...120, step: 1)
                    }
                    Stepper(value: $frequencyPerWeek, in: 1...7) {
                        Text("Frequency: \(frequencyPerWeek) times per week")
                    }
                    VStack(alignment: .leading) {
                        Text("Specific Days")
                        ForEach(0..<daysOfWeek.count, id: \.self) { index in
                            Toggle(isOn: $selectedDays[index]) {
                                Text(daysOfWeek[index])
                            }
                        }
                    }
                    Picker("Importance Level", selection: $importanceLevel) {
                        Text("Low").tag("Low")
                        Text("Medium").tag("Medium")
                        Text("High").tag("High")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Button(action: validateAndSaveRoutine) {
                    Text(routine == nil ? "Add Routine" : "Save Changes")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

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
                    isPresented = false
                }) {
                    Text("Back")
                        .foregroundColor(.blue)
                }
            )
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Invalid Selection"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .onAppear {
                if let routine = routine {
                    name = routine.name
                    duration = Double(routine.duration)
                    frequencyPerWeek = routine.frequencyPerWeek
                    selectedDays = daysOfWeek.map { routine.specificDays.contains($0) }
                    importanceLevel = routine.importanceLevel.rawValue
                }
            }
        }
    }

    private func validateAndSaveRoutine() {
        let selectedDaysArray = zip(daysOfWeek, selectedDays).compactMap { $1 ? $0 : nil }

        if selectedDaysArray.count != frequencyPerWeek {
            alertMessage = "The number of selected days (\(selectedDaysArray.count)) must match the frequency per week (\(frequencyPerWeek))."
            showAlert = true
        } else {
            saveRoutine(selectedDaysArray: selectedDaysArray)
        }
    }

    private func saveRoutine(selectedDaysArray: [String]) {
        guard let user = currentUser else { return }

        if let editingRoutine = routine {
            if let index = user.routines.firstIndex(where: { $0.id == editingRoutine.id }) {
                user.routines[index] = Routine(id: editingRoutine.id, name: name, duration: Int(duration), frequencyPerWeek: frequencyPerWeek, specificDays: selectedDaysArray, importanceLevel: ImportanceLevel(rawValue: importanceLevel)!)
            }
        } else {
            let newRoutine = Routine(name: name, duration: Int(duration), frequencyPerWeek: frequencyPerWeek, specificDays: selectedDaysArray, importanceLevel: ImportanceLevel(rawValue: importanceLevel)!)
            user.routines.append(newRoutine)
        }

        do {
            try modelContext.save()
        } catch {
            print("Error saving routines: \(error)")
        }

        isPresented = false
    }

    private func deleteRoutine() {
        guard let user = currentUser else { return }

        if let editingRoutine = routine, let index = user.routines.firstIndex(where: { $0.id == editingRoutine.id }) {
            user.routines.remove(at: index)
        }

        do {
            try modelContext.save()
        } catch {
            print("Error saving routines: \(error)")
        }

        isPresented = false
    }
}
