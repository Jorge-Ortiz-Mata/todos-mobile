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
        HStack {
            Text(title)
                .bold()
                .font(.largeTitle)
            Spacer()
        }
    }
}

#Preview {
    ScreenHeaderView(
        title: "Todos title"
    )
}
