//
//  TodoView.swift
//  todo-frontend
//
//  Created by Jorge on 16/01/24.
//

import SwiftUI

struct TodoRowView: View {
    var todo: TodoModel
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text(todo.name)
                        .fontWeight(.semibold)
                        .font(.title2)
                    Spacer()
                }
                
                HStack {
                    Text(todo.description)
                    Spacer()
                }
            }
            
            VStack {
                NavigationLink(destination: TodoScreenView(todoId: todo.id)) {
                    Image(systemName: "arrowshape.right.circle.fill")
                        .font(.title3)
                }
            }
        }
        .padding(.bottom, 5)
        .onAppear(){
//            formatCreatedAtDate()
        }
    }
    
//    func formatCreatedAtDate() {
//        let dateFormatter = DateFormatter()
//        let formatter = DateFormatter()
//
//        dateFormatter.dateFormat = "yyyy-mm-dd"
//        formatter.dateStyle = .long
//
//        if let date = dateFormatter.date(from: todo.created_at) {
//            creationDate = formatter.string(from: date)
//        }
//    }
}

#Preview {
    TodoRowView(
        todo: TodoModel(
            id: 1,
            name: "My first todo",
            description: "Some description about this todo"
        )
    )
}
