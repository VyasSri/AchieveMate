//
//  AuthScreen.swift
//  AchieveMate
//
//  Created by Thomas Pham on 9/27/24.
//

import SwiftUI

struct AuthView: View {
    @Binding var isAuthenticated: Bool
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()
                
                Text(".Logo")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(width: 230, height: 230)
                    .foregroundColor(.white)
                    .background(Color.black)
                Text("AchieveMate")
                    .font(.largeTitle)
                    .fontDesign(.monospaced)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                
                Spacer()
                Spacer()
                
                NavigationLink(destination: SignInView(isAuthenticated: $isAuthenticated)) {
                    Text("Sign in")
                        .font(.title3)
                        .fontDesign(.monospaced)
                        .fontWeight(.bold)
                        .padding(8)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
                
                Text("- or -")
                    .font(.subheadline)
                    .fontDesign(.monospaced)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.black)
                
                NavigationLink(destination: SignUpView(isAuthenticated: $isAuthenticated)) {
                    Text("Sign up")
                        .font(.headline)
                        .fontDesign(.monospaced)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.black)
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    AuthView(isAuthenticated: .constant(false))
}
