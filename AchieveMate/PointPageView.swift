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
    @State private var userPoints: Int = 1000  // You can replace this with dynamic data later
    
    var body: some View {
        //var User: User = User.shared
        VStack(spacing: 30) {
            // Title for the Points Page
            Text("Your Points")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // Display the user's current points
            Text("\(userPoints) Points")
                .font(.system(size: 50, weight: .bold, design: .rounded))
                .foregroundColor(.green)
            
            // Button to earn more points (you can add functionality later)
            Button(action: {
                // Example action: Add 100 points
                userPoints += 100
            }) {
                Text("Earn More Points")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

struct PointsPageView_Previews: PreviewProvider {
    static var previews: some View {
        PointsPageView()
    }
}

