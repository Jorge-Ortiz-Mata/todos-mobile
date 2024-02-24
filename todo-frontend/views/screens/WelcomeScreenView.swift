//
//  WelcomeScreenView.swift
//  todo-frontend
//
//  Created by Jorge on 25/01/24.
//

import SwiftUI

struct WelcomeScreenView: View {
    @AppStorage("todayTodosData") var todayTodosData: String = ""
    @AppStorage("welcomeLoading") var welcomeLoading: Bool = true
    @State var todos: [TodoModel] = []
    var todoService = TodoService()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                AppInfo()
                Spacer()
                
                if(welcomeLoading) {
                    ProgressView()
                } else {
                    NavigationLink(destination: TabNavigation().navigationBarBackButtonHidden(true)) {
                        HStack {
                            Text("Comenzar")
                            Image(systemName: "arrow.right")
                        }
                        .padding(.horizontal, 50)
                        .padding(.vertical, 10)
                        .foregroundColor(.black)
                        .font(.title3)
                        .fontWeight(.medium)
                        .background(.orange)
                        .cornerRadius(50)
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: [orangeColor, .black, .black]), startPoint: .top, endPoint: .bottom)
            )
            .onAppear(){
                Task {
                    await fetchTodos()
                }
            }

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
    
    private func fetchTodos() async {
        await todoService.getTodayTodos()
        await todoService.getTodosByDate(dateSelected: currentDate())
        UserDefaults.standard.set(currentDate(), forKey: "dateCalendarSelected")
    }
}

#Preview {
    WelcomeScreenView()
}
