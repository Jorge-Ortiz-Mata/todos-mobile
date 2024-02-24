//
//  ScreenHeaderView.swift
//  todo-frontend
//
//  Created by Jorge on 16/01/24.
//

import SwiftUI

struct ScreenHeaderView: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.title)
            .fontWeight(.bold)
            .padding(.vertical, 20)
            .foregroundColor(.white)
    }
}

#Preview {
    ScreenHeaderView(
        title: "Todos title"
    )
}
