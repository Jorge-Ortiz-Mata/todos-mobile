//
//  NewTodoScreen.swift
//  todo-frontend
//
//  Created by Jorge on 21/01/24.
//

import SwiftUI
import UserNotifications

struct NewTodoScreenView: View {
    var body: some View {
        VStack {
            NewTodoFormView()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(gradient: Gradient(colors: [orangeColor, .black, .black]), startPoint: .top, endPoint: .bottom)
        )
    }
}

#Preview {
    NewTodoScreenView()
}
