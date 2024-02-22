//
//  WelcomeScreenView.swift
//  todo-frontend
//
//  Created by Jorge on 25/01/24.
//

import SwiftUI

struct WelcomeScreenView: View {
    @AppStorage("todosData") var todosData: String = ""
    @AppStorage("welcomeLoading") var welcomeLoading: Bool = true
    @State var todos: [TodoModel] = []
    var todoService = TodoService()
    
    var body: some View {
        NavigationStack {
            VStack {
                WelcomeTitle()
                Spacer()
                AppInfo()
                Spacer()
                
                if(welcomeLoading) {
                    ProgressView()
                } else {
                    NavigationLink(destination: TabNavigation().navigationBarBackButtonHidden(true)) {
                        VStack {
                            Text("Comenzar")
                        }
                        .foregroundColor(.white)
                        .padding()
                        .font(.title3)
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .cornerRadius(10)
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: [.blue, .white, .white]), startPoint: .top, endPoint: .bottom)
            )
            .onAppear(){
                Task {
                    await fetchTodos()
                }
            }

        }
    }
    
    private func fetchTodos() async {
        await todoService.getTodos()
    }
}

#Preview {
    WelcomeScreenView()
}
