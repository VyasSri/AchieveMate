import SwiftUI
import SwiftData

struct AccountSettingsView: View {
    @Binding var isAuthenticated: Bool
    @Environment(\.modelContext) private var modelContext
    @State private var newPassword: String = ""
    @State private var currentUser: User?
    @State private var successMessage: String? // To show success message

    var body: some View {
        VStack(spacing: 20) {
            Text("Account Settings")
                .font(.largeTitle)
                .padding()

            // Change password section
            VStack(alignment: .leading, spacing: 10) {
                Text("Change Password")
                    .font(.headline)

                SecureField("New Password", text: $newPassword)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5)

                Button(action: {
                    changePassword()
                }) {
                    Text("Update Password")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()

            // Display success message when password is changed
            if let message = successMessage {
                Text(message)
                    .font(.subheadline)
                    .foregroundColor(.green)
                    .padding()
            }

            // Delete account section
            VStack(alignment: .leading, spacing: 10) {
                Text("Delete Account")
                    .font(.headline)
                    .foregroundColor(.red)

                Button(action: {
                    deleteAccount()
                }) {
                    Text("Delete Account")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()

            // Logout section
            Button(action: {
                logout()
            }) {
                Text("Logout")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            Spacer()
        }
        .onAppear {
            loadCurrentUser()
        }
    }

    // Function to change the password
    private func changePassword() {
        guard let user = currentUser else { return }

        // Update the password in the user object
        user.password = newPassword

        // Save the updated user to the CoreData context
        do {
            try modelContext.save()
            // Show success message
            successMessage = "Password changed successfully!"
            
            // Automatically hide the success message after 3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                successMessage = nil
            }
        } catch {
            print("Error updating password: \(error)")
        }
    }

    // Function to delete the account
    private func deleteAccount() {
        guard let user = currentUser else { return }

        // Delete the user from the CoreData context
        modelContext.delete(user)

        // Save the changes
        do {
            try modelContext.save()
            print("Account deleted successfully!")
        } catch {
            print("Error deleting account: \(error)")
        }
        
        // Remove userId from UserDefaults (for logging out)
        UserDefaults.standard.removeObject(forKey: "userId")
        
        isAuthenticated = false;
    }

    // Logout function
    private func logout() {
        // Remove userId from UserDefaults
        UserDefaults.standard.removeObject(forKey: "userId")

        isAuthenticated = false;
    }

    // Load the current user based on the stored userId
    private func loadCurrentUser() {
        if let userIdString = UserDefaults.standard.string(forKey: "userId"),
           let userId = UUID(uuidString: userIdString) {
            do {
                let users = try modelContext.fetch(FetchDescriptor<User>())
                if let user = users.first(where: { $0.id == userId }) {
                    currentUser = user
                }
            } catch {
                print("Error fetching user: \(error)")
            }
        }
    }
}

struct AccountSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSettingsView(isAuthenticated: .constant(false))
    }
}
