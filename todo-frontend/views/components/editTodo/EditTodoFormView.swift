//
//  EditTodoFormView.swift
//  todo-frontend
//
//  Created by Jorge on 25/01/24.
//

import SwiftUI

struct EditTodoFormView: View {
    @AppStorage("dateCalendarSelected") var dateCalendarSelected: String = ""
    @State var todo: TodoModel
    @State var nameError: String = ""
    @State var descriptionError: String = ""
    @State var dateError: String = ""
    @State var responseOK: Bool = false
    @State var todoDate: Date = Date()
    @Environment(\.presentationMode) var presentationMode
    var todoService = TodoService()
    
    var body: some View {
        VStack {
            if(responseOK) {
                VStack {
                    
                }.task {
                    await todoService.getTodayTodos()
                    await todoService.getTodosByDate(dateSelected: dateCalendarSelected)
                    presentationMode.wrappedValue.dismiss()
                }
            } else {
                VStack {
                    HStack {
                        CustomFormLabelView(label: "Nombre de la actividad:")
                        Spacer()
                    }
                    TextField("e.g. Go to the supermarket", text: $todo.name)
                        .padding(10)
                        .background(Color(red: 0.1, green: 0.1, blue: 0.1))
                        .cornerRadius(10)
                        .disableAutocorrection(true)
                        .foregroundStyle(.white)
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
                            await updateTodo()
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
        }.onAppear() {
            stringToDate(stringDate: todo.date)
        }
    }
    
    func stringToDate(stringDate: String) -> Void {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let dateObj = formatter.date(from: stringDate) else { return }
        
        todoDate = dateObj
    }
    
    func dateToString(date: Date) -> Void {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        todo.date = formatter.string(from: date)
    }
    
    func readbleDate(date: String) -> String {
        let dateSplitted = date.components(separatedBy: "-")
        let months: [String] = ["", "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]
        
        guard let month = Int(dateSplitted[1]) else { return "Error" }
        let monthName = months[month]
        
        let dateReadble = "\(dateSplitted[2]) \(monthName), \(dateSplitted[0])"
        
        return dateReadble
    }
    
    private func updateTodo() async {
        nameError = ""
        descriptionError = ""
        dateError = ""
        dateToString(date: todoDate)
        
        if let apiURL = URL(string: "\(apiURL)/todos/\(todo.id)") {
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
    EditTodoFormView(
        todo: TodoModel(
            id: 1,
            name: "My first todo",
            description: "Some description about this todo",
            date: "2024-03-03"
        )
    )
}
