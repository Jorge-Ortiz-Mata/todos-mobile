//
//  TabNavigation.swift
//  todo-frontend
//
//  Created by Jorge on 20/02/24.
//

import SwiftUI

struct TabNavigation: View {
    var body: some View {
        TabView {
            Group {
                TodosScreenView()
                    .tabItem {
                        Label("Menu", systemImage: "list.dash")
                }
                
                NewTodoScreenView()
                    .tabItem {
                        Label("Añadir", systemImage: "plus")
                    }
                
                CalendarScreenView()
                    .tabItem {
                        Label("Calendario", systemImage: "calendar")
                    }
            }
        }
    }
}

#Preview {
    TabNavigation()
}
