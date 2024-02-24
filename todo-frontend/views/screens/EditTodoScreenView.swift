//
//  EditTodoScreenView.swift
//  todo-frontend
//
//  Created by Jorge on 25/01/24.
//

import SwiftUI

struct EditTodoScreenView: View {
    var todo: TodoModel
    
    var body: some View {
        VStack {
            ScreenHeaderView(title: "Editar actividad")
            EditTodoFormView(todo: todo)
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [orangeColor, .black, .black]), startPoint: .top, endPoint: .bottom)
        )
    }
}

#Preview {
    EditTodoScreenView(
        todo: TodoModel(
            id: 1,
            name: "My first todo",
            description: "Some description about this todo",
            date: "2024-01-01"
        )
    )
}
