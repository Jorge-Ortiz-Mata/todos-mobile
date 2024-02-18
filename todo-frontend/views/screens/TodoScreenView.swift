//
//  TodoScreenView.swift
//  todo-frontend
//
//  Created by Jorge on 16/01/24.
//

import SwiftUI

struct TodoScreenView: View {
    var todoId: Int
    @AppStorage("todosData") var todosData: String = ""
    @State var isLoading: Bool = true
    @State var todo: TodoModel = TodoModel(id: 0, name: "", description: "")
    @State var isDeleted: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if(isLoading) {
                    ProgressView()
                } else {
                    if(isDeleted) {
                        Text("Your todo has been deleted successfully")
                    } else {
                        VStack {
                            HStack {
                                Text(todo.name)
                                    .font(.title)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                Spacer()
                            }
                            
                            HStack {
                                Text(todo.description)
                                Spacer()
                            }
                            
                            HStack {
                                NavigationLink(destination: EditTodoScreenView(todo: todo)) {
                                    Text("Edit todo")
                                }
                                
                                Button {
                                    Task {
                                        await deleteTodo(todoId: todo.id)
                                        await getTodos()
                                    }
                                } label: {
                                    Text("Delete todo")
                                }
                            }
                        }
                    }
                }
            }
            .onAppear() {
                Task {
                    await getTodo(todoId: todoId)
                }
            }
        }
    }
    
    private func getTodo(todoId: Int) async {
        if let apiURL = URL(string: "http://localhost:3000/api/todos/\(todoId)") {
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
        if let apiURL = URL(string: "http://localhost:3000/api/todos/\(todoId)") {
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
    
    private func getTodos() async {
        if let apiURL = URL(string: "http://localhost:3000/api/todos") {
            var request = URLRequest(url: apiURL)
            request.httpMethod = "GET"
            
            request.addValue("camel", forHTTPHeaderField: "Key-Inflection")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let apiData = data {
                    if let jsonData = try? JSONDecoder().decode(TodosModel.self, from: apiData) {
                        isLoading = false
                        UserDefaults.standard.set(jsonData.todos, forKey: "todosData")
                    }
                }
            }.resume()
        }
    }
}

#Preview {
    TodoScreenView(todoId: 1)
}


//await network.deleteTodo(id: id)
//await network.getTodos()
//self.presentationMode.wrappedValue.dismiss()
