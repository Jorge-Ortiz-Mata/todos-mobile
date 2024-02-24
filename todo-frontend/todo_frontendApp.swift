//
//  todo_frontendApp.swift
//  todo-frontend
//
//  Created by Jorge on 16/01/24.
//

import SwiftUI

@main
struct todo_frontendApp: App {
    @AppStorage("todayTodosData") var todayTodosData: String = ""
    
    var body: some Scene {
        WindowGroup {
            WelcomeScreenView()
        }
    }
}
