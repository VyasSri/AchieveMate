//
//  PointPageView.swift
//  AchieveMate
//
//  Created by Truman Shek on 9/23/24.
//
import SwiftData
import SwiftUI

struct PointsPageView: View {
    // Points property that holds the user's current points
    @State private var currentUser: User? // Store the current user
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationView {
            //var User: User = User.shared
            VStack(spacing: 30) {
                // Title for the Points Page
                Spacer()
                Text("Your Points")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // Display the user's current points
                if let user = currentUser {
                    Text("\(user.points) Points")
                        .font(.system(size: 50, weight: .bold, design: .rounded))
                        .foregroundColor(.green)
                }
                
                // Button to earn more points (you can add functionality later)
                //Doesnt work unless u made it so it saves to model context-thomas
                //            Button(action: {
                //                // Example action: Add 100 points
                //                if let user = currentUser {
                //                    user.points += 100
                //                }
                //            }) {
                //                Text("Earn More Points")
                //                    .font(.title2)
                //                    .padding()
                //                    .background(Color.blue)
                //                    .foregroundColor(.white)
                //                    .cornerRadius(10)
                //            }
                
                Spacer()
                
                NavigationLink(destination: DailyView()) {
                    Text("View Today's Routines")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.bottom, 20)
            }
            .padding()
            .onAppear() {
                loadCurrentUser();
            }
        }
    }
    
    // Load the current user based on the stored userId
    private func loadCurrentUser() {
        if let userIdString = UserDefaults.standard.string(forKey: "userId"),
           let userId = UUID(uuidString: userIdString) {
            do {
                let users = try modelContext.fetch(FetchDescriptor<User>())
                if let user = users.first(where: { $0.id == userId }) {
                    currentUser = user
                    //totalPoints = user.points
                }
            } catch {
                print("Error fetching user: \(error)")
            }
        }
    }
}

struct PointsPageView_Previews: PreviewProvider {
    static var previews: some View {
        PointsPageView()
    }
}

