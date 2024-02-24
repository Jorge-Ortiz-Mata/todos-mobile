//
//  TodoView.swift
//  todo-frontend
//
//  Created by Jorge on 16/01/24.
//

import SwiftUI

struct TodoCardView: View {
    var todo: TodoModel
    
    var body: some View {
        NavigationLink(destination: TodoScreenView(todoId: todo.id)) {
            VStack {
                HStack {
                    Text(todo.name)
                        .fontWeight(.bold)
                        .font(.title2)
                        .foregroundColor(.white)
                    Spacer()
                }

                
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.white)
                        .fontWeight(.light)
                        .font(.footnote)
                    Text(readbleDate(date: todo.date))
                        .foregroundColor(.white)
                        .fontWeight(.light)
                        .font(.footnote)
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.orange, lineWidth: 1)
            )
        }
        .padding(.bottom, 10)
    }
    
    private func readbleDate(date: String) -> String {
        if(date.count > 0) {
            let dateSplitted = date.components(separatedBy: "-")
            let months: [String] = ["", "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]
            
            guard let month = Int(dateSplitted[1]) else { return "Error" }
            let monthName = months[month]
            
            let dateReadble = "\(dateSplitted[2]) \(monthName), \(dateSplitted[0])"
            
            return dateReadble
        }
        
        return ""
    }
}

#Preview {
    TodoCardView(
        todo: TodoModel(
            id: 1,
            name: "My first todo",
            description: "Some description about this todo",
            date: "2024-01-01"
        )
    )
}
