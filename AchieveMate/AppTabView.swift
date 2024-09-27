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
                RoutinesView(isAuthenticated: $isAuthenticated)
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .tag(0)
                
                PointsPageView()
                    .tabItem {
                        Image(systemName: "trophy")
                        Text("Points")
                    }
                    .tag(1)
                
                AccountSettingsView()
                    .tabItem {
                        Image(systemName: "gearshape")
                        Text("Settings")
                    }
                    .tag(1)
            }
            .toolbar(.visible, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
        }
    }
}

#Preview {
    AppTabView(isAuthenticated: .constant(false))
}
