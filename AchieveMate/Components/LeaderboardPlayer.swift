//
//  LeaderboardPlayer.swift
//  AchieveMate
//
//  Created by Thomas Pham on 9/27/24.
//

import SwiftUI

struct LeaderboardPlayer: View {
    var username: String
    var points: Int
    var body: some View {
        Text("\(username) | \(points)")
            .font(.headline)
            .fontDesign(.monospaced)
            .fontWeight(.bold)
            .padding(8)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(5)
            .frame(width: 352, height: 44)
    }
}

#Preview {
    LeaderboardPlayer(username: "Thomas", points: 1000)
}
