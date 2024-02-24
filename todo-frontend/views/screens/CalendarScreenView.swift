//
//  CalendarScreenView.swift
//  todo-frontend
//
//  Created by Jorge on 21/02/24.
//

import SwiftUI

struct CalendarScreenView: View {
    @AppStorage("dateTodosData") var dateTodosData: String = ""
    @AppStorage("welcomeLoading") var welcomeLoading: Bool = true
    @State var todos: [TodoModel] = []
    @State var dateSelected: Date = Date()
    var todoService = TodoService()
    
    var body: some View {
        NavigationStack {
            VStack {
                ScreenHeaderView(title: "Calendario")
                HStack {
                    DatePicker(
                        "Start Date",
                        selection: $dateSelected,
                        displayedComponents: [.date]
                   )
                    .background(.black)
                    .datePickerStyle(.graphical)
                    .onChange(of: dateSelected) {
                       Task {
                           await fetchTodos()
                       }
                    }
                    .colorScheme(.dark)
                }
                .frame(maxWidth: .infinity)
                .background(.white)
                .padding(.top, 20)
                .padding(.bottom, 40)
                
                TodosByDateView()
                
                Spacer()
            }
            .padding()
            .background(
                LinearGradient(gradient: Gradient(colors: [orangeColor, .black, .black]), startPoint: .top, endPoint: .bottom)
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    private func currentDate() -> String {
        let date = dateSelected
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
    
    private func fetchTodos() async -> Void {
        let dateToString = currentDate()
        UserDefaults.standard.set(dateToString, forKey: "dateCalendarSelected")
        await todoService.getTodosByDate(dateSelected: dateToString)
    }
}

#Preview {
    CalendarScreenView()
}
