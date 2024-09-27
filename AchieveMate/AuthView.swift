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
                    VStack(spacing: 20) {
                        Text("Welcome to AchieveMate")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)

                        NavigationLink(destination: GetStartedView(isAuthenticated: $isAuthenticated)) {
                            Text("Get Started")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
//                        NavigationLink(destination: InstructionsView()) {
//                            Text("Instructions")
//                                .font(.headline)
//                                .padding()
//                                .frame(maxWidth: .infinity)
//                                .background(Color.gray)
//                                .foregroundColor(.white)
//                                .cornerRadius(10)
//                        }
                    }
                    .padding()
                }
            }

    }
}

#Preview {
    AuthView(isAuthenticated: .constant(false))
}
