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
        EditTodoFormView(todo: todo)
    }
}

#Preview {
    EditTodoScreenView(
        todo: TodoModel(
            id: 1,
            name: "My first todo",
            description: "Some description about this todo"
        )
    )
}
