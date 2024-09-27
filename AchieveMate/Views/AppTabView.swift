//
//  AppTabView.swift
//  AchieveMate
//
//  Created by Thomas Pham on 9/27/24.
//

import SwiftUI

struct AppTabView: View {
    @State private var selectedTab = 0
    @Binding var isAuthenticated: Bool
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                PointsPageView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .tag(1)
                
                RoutinesView(isAuthenticated: $isAuthenticated)
                    .tabItem {
                        Image(systemName: "plus")
                        Text("Add")
                    }
                    .tag(0)
                
                LeaderboardView()
                    .tabItem {
                        Image(systemName: "list.bullet.clipboard")
                        Text("Leaderboard")
                    }
                    .tag(0)
                
                AccountSettingsView(isAuthenticated: $isAuthenticated)
                    .tabItem {
                        Image(systemName: "gearshape")
                        Text("Settings")
                    }
                    .tag(1)
            }
            .toolbar(.visible, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .accentColor(Color("RevBackgroundClr"))
        }
    }
}

#Preview {
    AppTabView(isAuthenticated: .constant(false))
}
