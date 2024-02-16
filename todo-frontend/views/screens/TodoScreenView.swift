//
//  TodoScreenView.swift
//  todo-frontend
//
//  Created by Jorge on 16/01/24.
//

import SwiftUI

struct TodoScreenView: View {
    @State var isLoading: Bool = true
    
    var body: some View {
        NavigationStack {
            Text("Todo Screen")
        }
    }
}

#Preview {
    TodoScreenView()
}

// @Environment(\.presentationMode) var presentationMode
//await network.deleteTodo(id: id)
//await network.getTodos()
//self.presentationMode.wrappedValue.dismiss()
