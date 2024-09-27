import SwiftUI
import SwiftData

struct SignUpView: View {
    @Binding var isAuthenticated: Bool
    @State private var showingAlert = false
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
                .alert("Invalid Email", isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }

            SecureField("Password", text: $newUser.password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5)

            Button(action: {
                if (isValidEmail(newUser.email)) {
                    signUp()
                } else {
                    showingAlert = true
                }
            }) {
                Text("Create Account")
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
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
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
