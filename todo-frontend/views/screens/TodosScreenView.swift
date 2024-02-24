//
//  TodosView.swift
//  todo-frontend
//
//  Created by Jorge on 16/01/24.
//

import SwiftUI

struct TodosScreenView: View {
    @AppStorage("todayTodosData") var todayTodosData: String = ""
    @State var todos: [TodoModel] = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                UsernameView()
                
                HStack {
                    Text("El dia de hoy tienes \(todos.count) actividades por completar")
                        .foregroundColor(.white)
                        .font(.title3)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 30)
            
                ForEach(todos) { todo in
                    TodoCardView(todo: todo)
                }
            }
            .padding(20)
            .background(
                LinearGradient(gradient: Gradient(colors: [orangeColor, .black, .black]), startPoint: .top, endPoint: .bottom)
            )
        }
        .onAppear() {
            transformData()
        }
    }
    
    private func transformData() -> Void {
        let jsonFormattedData = todayTodosData.data(using: .utf8)!
    
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
