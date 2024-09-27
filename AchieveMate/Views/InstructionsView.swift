//
//  InstructionsView.swift
//  AchieveMate
//
//  Created by Vyas Sriman on 9/3/24.
//

import Foundation
import SwiftUI

struct InstructionsView: View {
    var body: some View {
        VStack {
            Text("How to Use the App")
                .font(.largeTitle)
                .padding()
            
            Text("Instructions go here")
                .padding()
            
            Spacer()
        }
        .padding()
    }
}

struct InstructionsView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionsView()
    }
}
