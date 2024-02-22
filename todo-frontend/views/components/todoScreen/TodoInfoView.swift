//
//  TodoInfoView.swift
//  todo-frontend
//
//  Created by Jorge on 21/02/24.
//

import SwiftUI

struct TodoInfoView: View {
    var todo: TodoModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Nombre de la actividad:")
                    .foregroundColor(.black)
                Spacer()
            }
            HStack {
                Text(todo.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Spacer()
            }
        }
        .padding(.bottom, 20)
        
        VStack {
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(.black)
                Text("Fecha:")
                    .foregroundColor(.black)
                Spacer()
            }
            HStack {
                Text(readbleDate(date: todo.date))
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)

                Spacer()
            }
        }
        .padding(.bottom, 20)
        
        VStack {
            HStack {
                Text("Nombre de la actividad:")
                    .foregroundColor(.black)
                Spacer()
            }
            HStack {
                Text(todo.description)
                    .foregroundColor(.black)
                    .font(.title3)
                    .fontWeight(.bold)

                Spacer()
            }
        }
        .padding(.bottom, 20)
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
    TodoInfoView(
        todo: TodoModel(
            id: 1,
            name: "My first todo",
            description: "Some description about this todo",
            date: "2024-03-03"
        )
    )
}
