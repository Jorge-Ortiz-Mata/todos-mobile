//
//  TodosView.swift
//  todo-frontend
//
//  Created by Jorge on 16/01/24.
//

import SwiftUI

struct TodosScreenView: View {
    @AppStorage("todosData") var todosData: String = ""
    @State var newTodoState: Bool = false
    @State var todos: [TodoModel] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: NewTodoScreen()) {
                    Text("Add new todo")
                }
                .padding(.bottom, 10)
                
                
                ForEach(todos) { todo in
                    TodoRowView(todo: todo)
                }
            }
            
        }
        .sheet(isPresented: $newTodoState) {
            NewTodoScreen()
        }
        .onAppear() {
            transformData()
        }
    }
    
    private func transformData() -> Void {
        let jsonFormattedData = todosData.data(using: .utf8)!
    
        do {
            let objects = try JSONDecoder().decode([TodoModel].self, from: jsonFormattedData)
            todos = objects
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
}

#Preview {
    TodosScreenView()
}
