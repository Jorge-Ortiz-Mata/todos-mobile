//
//  FormView.swift
//  todo-frontend
//
//  Created by Jorge on 21/01/24.
//

import SwiftUI

struct NewTodoFormView: View {
    @AppStorage("todayTodosData") var todayTodosData: String = ""
    @Environment(\.presentationMode) var presentationMode
    @State var todo: NewTodo = NewTodo(name: "", description: "", date: "")
    @State var todoDate: Date = Date()
    @State var nameError: String = ""
    @State var descriptionError: String = ""
    @State var dateError: String = ""
    @State var responseOK: Bool = false
    var todoService = TodoService()
    
    var body: some View {
        VStack {
            if(responseOK) {
                VStack {
                    MessageOK()
                    Button {
                        resetForm()
                    } label: {
                        Text("Añadir actividad")
                            .padding(.top, 5)
                    }
                }.task {
                    await todoService.getTodayTodos()
                }
            } else {
                VStack {
                    ScreenHeaderView(title: "Agregar actividad")
                    HStack {
                        CustomFormLabelView(label: "Nombre de la actividad:")
                        Spacer()
                    }
                    TextField("e.g. Hacer el pago de la tarjeta", text: $todo.name)
                        .padding(10)
                        .background(Color(red: 0.1, green: 0.1, blue: 0.1))
                        .cornerRadius(10)
                        .disableAutocorrection(true)
                        .foregroundColor(.white)
                    if nameError.count > 0 {
                        CustomErrorMessageView(message: nameError)
                    }
                    
                }
                .padding(.bottom, 20)
                
                HStack {
                    CustomFormLabelView(label: "Fecha:")
                    Spacer()
                    
                    DatePicker(
                        "",
                        selection: $todoDate,
                        displayedComponents: [.date]
                    )
                    .colorScheme(.dark)
                    if dateError.count > 0 {
                        CustomErrorMessageView(message: dateError)
                    }
                    
                }
                .textFieldStyle(.roundedBorder)
                .padding(.bottom, 20)
                
                VStack {
                    HStack {
                        CustomFormLabelView(label: "Descripcion (opcional):")
                        Spacer()
                    }
                    TextEditor(text: $todo.description)
                        .frame(height: 100)
                        .padding(2)
                        .background(Color(red: 0.1, green: 0.1, blue: 0.1))
                        .disableAutocorrection(true)
                        .scrollContentBackground(.hidden) // <- Hide it
                        .background(.white)
                        .foregroundColor(.white)
                    if descriptionError.count > 0 {
                        CustomErrorMessageView(message: descriptionError)
                    }
                }
                .padding(.bottom, 20)
                
                Spacer()
                
                VStack {
                    Button {
                        Task {
                            await saveTodo()
                        }
                    } label: {
                        HStack {
                            Text("Guardar")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue)
                        .fontWeight(.medium)
                        .cornerRadius(5)
                        .foregroundColor(.white)
                    }
                }
            }
        }
    }
    
    func resetForm() -> Void {
        responseOK = false
        todo.name = ""
        todo.description = ""
        todo.date = ""
        todoDate = Date()
    }
    
    func dateToString(date: Date) -> Void {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        todo.date = formatter.string(from: date)
    }
    
    func saveTodo () async {
        nameError = ""
        descriptionError = ""
        dateError = ""
        dateToString(date: todoDate)
        
        if let apiURL = URL(string: "\(apiURL)/todos") {
            var request = URLRequest(url: apiURL)
            let jsonData = try? JSONEncoder().encode(todo)
            request.httpMethod = "POST"
            request.addValue("camel", forHTTPHeaderField: "Key-Inflection")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let response = response as? HTTPURLResponse {
                    
                    if response.statusCode == 422 {
                        responseOK = false

                        if let apiData = data {
                            if let response = try? JSONDecoder().decode(TodoErrors.self, from: apiData) {
                                if let nameErrors = response.name {
                                    nameError = "El nombre \(nameErrors[0])"
                                }
                                if let descriptionErrors = response.description {
                                    descriptionError = "La descripcion \(descriptionErrors[0])"
                                }
                                if let dateErrors = response.date {
                                    dateError = "La fecha \(dateErrors[0])"
                                }

                            }
                        }

                    } else if response.statusCode == 200 {
                        responseOK = true
                    }
                }
            }.resume()
        }
    }
}

#Preview {
    NewTodoFormView()
}
