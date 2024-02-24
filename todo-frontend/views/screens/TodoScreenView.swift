//
//  TodoScreenView.swift
//  todo-frontend
//
//  Created by Jorge on 16/01/24.
//

import SwiftUI

struct TodoScreenView: View {
    @AppStorage("todayTodosData") var todayTodosData: String = ""
    @AppStorage("dateCalendarSelected") var dateCalendarSelected: String = ""
    @State var isLoading: Bool = true
    @State var todo: TodoModel = TodoModel(id: 0, name: "", description: "", date: "")
    @State var showAlert: Bool = false
    @State var isDeleted: Bool = false
    var todoService = TodoService()
    var todoId: Int
    
    var body: some View {
        NavigationStack {
            VStack {
                if(isLoading) {
                    ProgressView()
                } else {
                    if(isDeleted) {
                        VStack {
                            Text("Actividad eliminada")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.bottom, 10)
                            Text("La actividad ha sido eliminada correctamente.")
                                .foregroundColor(.black)
                        }.task {
                            await todoService.getTodayTodos()
                            await todoService.getTodosByDate(dateSelected: dateCalendarSelected)
                        }
                    } else {
                        VStack {
                            ScreenHeaderView(title: "Actividad")
                            TodoInfoView(todo: todo)
                            
                            Spacer()
                            
                            VStack {
                                NavigationLink(destination: EditTodoScreenView(todo: todo)) {
                                    Text("Editar")
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(.blue)
                                        .cornerRadius(5)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                    
                                }
                                .padding(.bottom, 5)
                                
                                Button {
                                    showAlert = true
                                } label: {
                                    Text("Eliminar")
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(.red)
                                        .cornerRadius(5)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                }
                                .alert("¿Estas seguro de eliminar esta actividad?", isPresented: $showAlert) {
                                    Button("Cancelar", role: .cancel) { }
                                    Button("Aceptar") {
                                        Task {
                                            await deleteTodo(todoId: todo.id)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: [orangeColor, .black, .black]), startPoint: .top, endPoint: .bottom)
            )
            .onAppear() {
                Task {
                    await getTodo(todoId: todoId)
                }
            }
        }
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
    
    private func getTodo(todoId: Int) async {
        if let apiURL = URL(string: "\(apiURL)/todos/\(todoId)") {
            var request = URLRequest(url: apiURL)
            request.httpMethod = "GET"
            request.addValue("camel", forHTTPHeaderField: "Key-Inflection")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let apiData = data {
                    if let jsonData = try? JSONDecoder().decode(TodoModel.self, from: apiData) {
                        isLoading = false
                        todo = jsonData
                    }
                }
            }.resume()
        }
    }
    
    private func deleteTodo(todoId: Int) async {
        if let apiURL = URL(string: "\(apiURL)/todos/\(todoId)") {
            var request = URLRequest(url: apiURL)
            request.httpMethod = "DELETE"
            request.addValue("camel", forHTTPHeaderField: "Key-Inflection")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let apiData = data {
                    isDeleted = true
                }
            }.resume()
        }
    }
}

#Preview {
    TodoScreenView(todoId: 1)
}
