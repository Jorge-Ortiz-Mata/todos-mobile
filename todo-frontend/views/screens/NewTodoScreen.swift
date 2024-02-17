//
//  NewTodoScreen.swift
//  todo-frontend
//
//  Created by Jorge on 21/01/24.
//

import SwiftUI

struct NewTodoScreen: View {
    var body: some View {
        VStack {
            Text("Create todo")
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            NewTodoFormView()
        }
    }
}

#Preview {
    NewTodoScreen()
}
