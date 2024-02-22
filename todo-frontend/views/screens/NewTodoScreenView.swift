//
//  NewTodoScreen.swift
//  todo-frontend
//
//  Created by Jorge on 21/01/24.
//

import SwiftUI

struct NewTodoScreenView: View {
    var body: some View {
        VStack {
            NewTodoFormView()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
    }
}

#Preview {
    NewTodoScreenView()
}
