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
            .padding(.bottom, 20)
            .foregroundStyle(.black)
        
    }
}

#Preview {
    ScreenHeaderView(
        title: "Todos title"
    )
}
