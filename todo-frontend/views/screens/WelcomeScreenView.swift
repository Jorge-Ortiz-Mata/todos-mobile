//
//  WelcomeScreenView.swift
//  todo-frontend
//
//  Created by Jorge on 25/01/24.
//

import SwiftUI

struct WelcomeScreenView: View {
    @AppStorage("todosData") var todosData: String = ""
    @State var isLoading: Bool = true
    @State var todos: [TodoModel] = []
    
    var body: some View {
        VStack {
            VStack {
                NavigationStack {
                    Spacer()
                    VStack {
                        Image("ux-ui")
                            .resizable()
                        .frame(width: 300, height: 300)
                        Text("Todo App")
                            .bold()
                            .font(.title)
                    }
                    Spacer()
                    
                    if(isLoading) {
                        ProgressView()
                    } else {
                        NavigationLink(destination: TodosScreenView()) {
                            Text("Let's start")
                        }
                    }
                }
            }
            .onAppear(){
                Task {
                    await getTodos()
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
                        isLoading = false
                        UserDefaults.standard.set(jsonData.todos, forKey: "todosData")
                    }
                }
            }.resume()
        }
    }
}

#Preview {
    WelcomeScreenView()
}
