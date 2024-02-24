//
//  TodoService.swift
//  todo-frontend
//
//  Created by Jorge on 17/02/24.
//

import Foundation
import SwiftUI

class TodoService: ObservableObject {
    @AppStorage("todayTodosData") var todayTodosData: String = ""
    @AppStorage("welcomeLoading") var welcomeLoading: Bool = true
    @AppStorage("dateTodosData") var dateTodosData: String = ""
    @AppStorage("dateCalendarSelected") var dateCalendarSelected: String = ""
    @AppStorage("calendarLoading") var calendarLoading: Bool = false
    
    func getTodayTodos() async {
        UserDefaults.standard.set(true, forKey: "welcomeLoading")
        
        if let apiURL = URL(string: "\(apiURL)/todos") {
            var request = URLRequest(url: apiURL)
            request.httpMethod = "GET"
            request.addValue("camel", forHTTPHeaderField: "Key-Inflection")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue(currentDate(), forHTTPHeaderField: "CURRENT_DATE")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let apiData = data {
                    if let jsonData = try? JSONDecoder().decode(TodosModel.self, from: apiData) {
                        UserDefaults.standard.set(jsonData.todos, forKey: "todayTodosData")
                        UserDefaults.standard.set(false, forKey: "welcomeLoading")
                    }
                }
            }.resume()
        }
    }
    
    func getTodosByDate(dateSelected: String) async {
        UserDefaults.standard.set(true, forKey: "calendarLoading")
        
        if let apiURL = URL(string: "\(apiURL)/todos") {
            var request = URLRequest(url: apiURL)
            request.httpMethod = "GET"
            request.addValue("camel", forHTTPHeaderField: "Key-Inflection")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue(dateSelected, forHTTPHeaderField: "CURRENT_DATE")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let apiData = data {
                    if let jsonData = try? JSONDecoder().decode(TodosModel.self, from: apiData) {
                        UserDefaults.standard.set(jsonData.todos, forKey: "dateTodosData")
                        UserDefaults.standard.set(false, forKey: "welcomeLoading")
                    }
                }
            }.resume()
        }
    }
    
    private func currentDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: date)
        
        if(formattedDate.count > 0) {
            let dateSplitted = formattedDate.components(separatedBy: "-")
            let months: [String] = ["", "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]
            
            guard let month = Int(dateSplitted[1]) else { return "Error" }
            let monthName = months[month]
            
            let dateReadble = "\(dateSplitted[2]) \(monthName), \(dateSplitted[0])"
            
            return dateReadble
        }
        
        return ""
    }
}
