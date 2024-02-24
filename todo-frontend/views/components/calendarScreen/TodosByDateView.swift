//
//  TodosByDateView.swift
//  todo-frontend
//
//  Created by Jorge on 22/02/24.
//

import SwiftUI

struct TodosByDateView: View {
    @AppStorage("dateTodosData") var dateTodosData: String = ""
    @State var todos: [TodoModel] = []
    
    var body: some View {
        VStack {
            if(todos.count > 0) {
                ForEach(todos) { todo in
                    TodoCardView(todo: todo)
                }
            } else {
                Text("No hay actividades registradas")
                    .foregroundColor(.white)
            }
        }.onChange(of: dateTodosData) {
            transformData()
        }.onAppear(){
            transformData()
        }
    }
    
    private func transformData() -> Void {
        if(dateTodosData.count > 0) {
            let jsonFormattedData = dateTodosData.data(using: .utf8)!
        
            do {
                let objects = try JSONDecoder().decode([TodoModel].self, from: jsonFormattedData)
                todos = objects
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
    }
}

#Preview {
    TodosByDateView()
}
