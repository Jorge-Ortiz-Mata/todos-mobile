//
//  TodosView.swift
//  todo-frontend
//
//  Created by Jorge on 16/01/24.
//

import SwiftUI

struct TodosScreenView: View {
    @AppStorage("todosData") var todosData: String = ""
    @State var todos: [TodoModel] = []
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                UsernameView()
                
                HStack {
                    Image(systemName: "text.badge.checkmark")
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(red: 0.4, green: 0.4, blue: 0.4))
                    Text("Actividades de hoy")
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(red: 0.4, green: 0.4, blue: 0.4))
                    Spacer()
                }
                .padding(.top, 10)
                Divider()
                    .padding(.bottom, 10)
        
                LazyVGrid(columns: columns) {
                    ForEach(todos) { todo in
                        TodoCardView(todo: todo)
                    }
                }
            }
            .padding()
            .background(.white)
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
