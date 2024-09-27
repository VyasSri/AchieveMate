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
            Text("Leaderboard")
            ScrollView {
                LazyVStack(spacing: 0) {
                    LeaderboardPlayer(username: "James", points: 5000)
                    LeaderboardPlayer(username: "Truman", points: 0)
                    LeaderboardPlayer(username: "Poop", points: -500)
                    LeaderboardPlayer(username: "Poop", points: -500)
                    LeaderboardPlayer(username: "Poop", points: -500)
                    LeaderboardPlayer(username: "Poop", points: -500)
                    LeaderboardPlayer(username: "James", points: 5000)
                    LeaderboardPlayer(username: "Truman", points: 0)
                    LeaderboardPlayer(username: "Poop", points: -500)
                    LeaderboardPlayer(username: "Poop", points: -500)
                    LeaderboardPlayer(username: "Poop", points: -500)
                    LeaderboardPlayer(username: "Poop", points: -500)
                    LeaderboardPlayer(username: "James", points: 5000)
                    LeaderboardPlayer(username: "Truman", points: 0)
                    LeaderboardPlayer(username: "Poop", points: -500)
                    LeaderboardPlayer(username: "Poop", points: -500)
                    LeaderboardPlayer(username: "Poop", points: -500)
                    LeaderboardPlayer(username: "Poop", points: -500)
                }
            }
        }
    }
}

#Preview {
    LeaderboardView()
}
