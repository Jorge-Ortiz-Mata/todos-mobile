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
                    
                    if(welcomeLoading) {
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
