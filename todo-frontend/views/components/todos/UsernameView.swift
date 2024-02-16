//
//  UsernameView.swift
//  todo-frontend
//
//  Created by Jorge on 16/01/24.
//

import SwiftUI

struct UsernameView: View {
    var name: String
    
    var body: some View {
        HStack {
            Text("Hello, \(name)")
                .bold()
            Spacer()
        }
    }
}

#Preview {
    UsernameView(name: "Jorge")
}
