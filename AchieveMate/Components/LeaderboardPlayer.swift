//
//  LeaderboardPlayer.swift
//  AchieveMate
//
//  Created by Thomas Pham on 9/27/24.
//

import SwiftUI

struct LeaderboardPlayer: View {
    var place: Int
    var username: String
    var points: Int
    var body: some View {
        HStack {
            Text("\(place)")
            Circle()
                .frame(width: 44, height: 44)
            Text("\(username)")
                .font(.title3)
            Spacer()
            Text("\(points) pts")
        }
        .font(.headline)
        .fontDesign(.monospaced)
        .fontWeight(.bold)
        .padding(8)
        .frame(maxWidth: .infinity)
        //.background(Color.blue)
        .foregroundColor(Color("RevBackgroundClr"))
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    LeaderboardPlayer(place: 1, username: "Thomas", points: 1000)
}
