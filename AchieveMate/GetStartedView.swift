import SwiftUI

struct GetStartedView: View {
    @Binding var isAuthenticated: Bool

    var body: some View {
        VStack(spacing: 20) {
            Text("Log In / Sign Up")
                .font(.largeTitle)
                .padding()

            NavigationLink(destination: SignUpView(isAuthenticated: $isAuthenticated)) {
                Text("Sign Up")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            NavigationLink(destination: SignInView(isAuthenticated: $isAuthenticated)) {
                Text("Sign In")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

struct SignUpSignInView_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedView(isAuthenticated: .constant(false))
    }
}
