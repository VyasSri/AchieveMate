import SwiftUI

struct MultiSelectPicker: View {
    @Binding var selectedItems: Set<String>
    let options: [String]

    var body: some View {
        VStack {
            ForEach(options, id: \.self) { option in
                Button(action: {
                    toggleSelection(for: option)
                }) {
                    HStack {
                        Text(option)
                        Spacer()
                        if selectedItems.contains(option) {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5)
            }
        }
    }

    private func toggleSelection(for option: String) {
        if selectedItems.contains(option) {
            selectedItems.remove(option)
        } else {
            selectedItems.insert(option)
        }
    }
}
