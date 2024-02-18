//
//  EditTodoFormView.swift
//  todo-frontend
//
//  Created by Jorge on 25/01/24.
//

import SwiftUI

struct EditTodoFormView: View {
    @State var todo: TodoModel
    @State var nameError: String = ""
    @State var descriptionError: String = ""
    @State var responseOK: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            if(responseOK) {
                VStack {
                    
                }.task {
                    await getTodos()
                    presentationMode.wrappedValue.dismiss()
                }
            } else {
                VStack {
                    HStack {
                        CustomFormLabelView(label: "Nombre")
                        Spacer()
                    }
                    TextField("e.g. Go to the supermarket", text: $todo.name)
                        .border(.gray)
                        .border(Color(red: 0.8, green: 0.8, blue: 0.8))
                        .disableAutocorrection(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    if nameError.count > 0 {
                        CustomErrorMessageView(message: nameError)
                    }
                }
                .textFieldStyle(.roundedBorder)
                .padding(.bottom, 20)
                
                VStack {
                    HStack {
                        CustomFormLabelView(label: "Descripcion")
                        Spacer()
                    }
                    TextEditor(text: $todo.description)
                        .border(Color(red: 0.8, green: 0.8, blue: 0.8))
                        .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    if descriptionError.count > 0 {
                        CustomErrorMessageView(message: descriptionError)
                    }
                }
                .textFieldStyle(.roundedBorder)
                .padding(.bottom, 20)
                
                VStack {
                    Button("Save") {
                        Task {
                            await updateTodo()
                        }
                    }
                    .padding()
                    .background(Color(red: 0, green: 0.5, blue: 0.5))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                }
                
            }
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
                        UserDefaults.standard.set(jsonData.todos, forKey: "todosData")
                    }
                }
            }.resume()
        }
    }
    
    private func updateTodo() async {
        nameError = ""
        descriptionError = ""
        
        if let apiURL = URL(string: "http://localhost:3000/api/todos/\(todo.id)") {
            var request = URLRequest(url: apiURL)
            let jsonData = try? JSONEncoder().encode(todo)
            request.httpMethod = "PATCH"
            request.addValue("camel", forHTTPHeaderField: "Key-Inflection")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let response = response as? HTTPURLResponse {
                    
                    if response.statusCode == 422 {
                        if let apiData = data {
                            if let response = try? JSONDecoder().decode(TodoErrors.self, from: apiData) {
                                if let nameErrors = response.name {
                                    nameError = "El nombre \(nameErrors[0])"
                                }
                                if let descriptionErrors = response.description {
                                    descriptionError = "La descripcion \(descriptionErrors[0])"
                                }

                            }
                        }
                    } else if response.statusCode == 200 {
                        responseOK = true
                        
                        if let apiData = data {
                            if let response = try? JSONDecoder().decode(Todo.self, from: apiData) { 
                                print(response)
                            }
                        }
                    }
                }
            }.resume()
        }
    }
}

#Preview {
    EditTodoFormView(
        todo: TodoModel(
            id: 1,
            name: "My first todo",
            description: "Some description about this todo"
        )
    )
}
