//
//  EditTodoScreenView.swift
//  todo-frontend
//
//  Created by Jorge on 25/01/24.
//

import SwiftUI

struct EditTodoScreenView: View {
    var todo: Todo
    
    var body: some View {
        EditTodoFormView(todo: todo)
    }
}

#Preview {
    EditTodoScreenView(
        todo: Todo(
            id: 1,
            name: "My first todo",
            description: "Some description about this todo",
            createdAt: "2024-01-15",
            updatedAt: "2024-01-18"
        )
    )
}
