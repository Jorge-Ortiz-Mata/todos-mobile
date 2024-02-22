//
//  WelcomeTitle.swift
//  todo-frontend
//
//  Created by Jorge on 20/02/24.
//

import SwiftUI

struct WelcomeTitle: View {
    var body: some View {
        HStack {
            Text("DoTask")
                .font(.largeTitle)
                .foregroundColor(.white)
                .fontWeight(.heavy)
        }
    }
}

#Preview {
    WelcomeTitle()
}
