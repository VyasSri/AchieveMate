import SwiftUI
import SwiftData

struct SignUpView: View {
    @Binding var isAuthenticated: Bool
    @Environment(\.modelContext) private var modelContext
    @State private var newUser = User(name: "", email: "", password: "") // User model

    var body: some View {
        VStack(spacing: 20) {
            Text("Sign Up")
                .font(.largeTitle)
                .padding()

            TextField("Username", text: $newUser.name)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5)

            TextField("Email", text: $newUser.email)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)

            SecureField("Password", text: $newUser.password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5)

            Button(action: {
                signUp()
            }) {
                Text("Create Account")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
        }
        .padding()
    }
    
    private func signUp() {
        // Save user data to SwiftData
        modelContext.insert(newUser)
        
        // Save userId to UserDefaults for future authentication
        UserDefaults.standard.set(newUser.id.uuidString, forKey: "userId")
        
        // Set the user as authenticated
        isAuthenticated = true
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(isAuthenticated: .constant(false))
    }
}
