import SwiftUI
import SwiftData

struct SignInView: View {
    @Binding var isAuthenticated: Bool
    @Environment(\.modelContext) private var modelContext // Access the SwiftData context
    @State private var username: String = "" // User-entered username
    @State private var password: String = "" // User-entered password
    @State private var signInFailed: Bool = false // Track sign-in failure

    var body: some View {
        VStack(spacing: 20) {
            Text("Sign In")
                .font(.largeTitle)
                .padding()

            // Text field for username input
            TextField("Username", text: $username)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5)

            // Secure field for password input
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5)

            // Display error message if sign-in fails
            if signInFailed {
                Text("Invalid username or password. Please try again.")
                    .foregroundColor(.red)
            }

            // Sign In button
            Button(action: {
                signIn()
            }) {
                Text("Sign In")
                    .font(.title3)
                    .fontDesign(.monospaced)
                    .fontWeight(.bold)
                    .foregroundColor(Color("BackgroundClr"))
                    .padding(8)
                    .frame(width: 352, height: 44)
                    .background(Color("RevBackgroundClr"))
                    .cornerRadius(5)
            }
            .padding(.top, 20)
        }
        .padding()
    }

    // Function to handle user sign-in
    private func signIn() {
        // Fetch the list of users from the database and compare credentials
        do {
            let users = try modelContext.fetch(FetchDescriptor<User>())
            
            // Find the first user that matches the entered username and password
            if let matchingUser = users.first(where: { $0.name == username && $0.password == password }) {
                // If found, set the authenticated userId in UserDefaults
                UserDefaults.standard.set(matchingUser.id.uuidString, forKey: "userId")
                
                // Set the user as authenticated
                isAuthenticated = true
                signInFailed = false // Reset the failure flag if login succeeds
            } else {
                // If no match, display error
                signInFailed = true
            }
        } catch {
            print("Error fetching users: \(error)")
            signInFailed = true // Show error if there is an issue with fetching
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(isAuthenticated: .constant(false))
    }
}
