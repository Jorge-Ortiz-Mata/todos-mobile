//
//  TodoService.swift
//  todo-frontend
//
//  Created by Jorge on 17/02/24.
//

import Foundation
import SwiftUI

class TodoService: ObservableObject {
    @AppStorage("todosData") var todosData: String = ""
    @AppStorage("welcomeLoading") var welcomeLoading: Bool = true
    
    func getTodos() async {
        UserDefaults.standard.set(true, forKey: "welcomeLoading")
        
        if let apiURL = URL(string: "http://localhost:3000/api/todos") {
            var request = URLRequest(url: apiURL)
            request.httpMethod = "GET"
            
            request.addValue("camel", forHTTPHeaderField: "Key-Inflection")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let apiData = data {
                    if let jsonData = try? JSONDecoder().decode(TodosModel.self, from: apiData) {
                        UserDefaults.standard.set(jsonData.todos, forKey: "todosData")
                        UserDefaults.standard.set(false, forKey: "welcomeLoading")
                    }
                }
            }.resume()
        }
    }
}
