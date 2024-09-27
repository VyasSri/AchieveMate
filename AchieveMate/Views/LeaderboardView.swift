//
//  LeaderboardView.swift
//  AchieveMate
//
//  Created by Thomas Pham on 9/27/24.
// this shit is not done

import SwiftUI

struct LeaderboardView: View {
    var body: some View {
        VStack {
            //Replace with division Images
            HStack {
                Circle()
                    .frame(width: 60, height: 60)
                Circle()
                    .frame(width: 60, height: 60)
                Circle()
                    .frame(width: 60, height: 60)
                Circle()
                    .frame(width: 60, height: 60)
                Circle()
                    .frame(width: 80, height: 80)
            }
            .padding(12)
            
            Text("Division: Radiant")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Ends in 5d, 3h, 1m, 10s")
                .font(.headline)
                .fontDesign(.monospaced)
            Divider()
            ScrollView {
                LazyVStack(spacing: 0) {
                    LeaderboardPlayer(place: 1, username: "James", points: 5000)
                    LeaderboardPlayer(place: 2, username: "James", points: 5000)
                    LeaderboardPlayer(place: 3, username: "James", points: 5000)
                    LeaderboardPlayer(place: 4, username: "James", points: 5000)
                    LeaderboardPlayer(place: 1, username: "James", points: 5000)
                    LeaderboardPlayer(place: 2, username: "James", points: 5000)
                    LeaderboardPlayer(place: 3, username: "James", points: 5000)
                    LeaderboardPlayer(place: 4, username: "James", points: 5000)
                    LeaderboardPlayer(place: 1, username: "James", points: 5000)
                    LeaderboardPlayer(place: 2, username: "James", points: 5000)
                    LeaderboardPlayer(place: 3, username: "James", points: 5000)
                    LeaderboardPlayer(place: 4, username: "James", points: 5000)
                    LeaderboardPlayer(place: 1, username: "James", points: 5000)
                    LeaderboardPlayer(place: 2, username: "James", points: 5000)
                    LeaderboardPlayer(place: 3, username: "James", points: 5000)
                    LeaderboardPlayer(place: 4, username: "James", points: 5000)
                }
            }
        }
    }
}

#Preview {
    LeaderboardView()
}
