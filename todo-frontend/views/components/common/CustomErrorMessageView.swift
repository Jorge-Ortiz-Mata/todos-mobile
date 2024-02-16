//
//  CustomErrorMessageView.swift
//  todo-frontend
//
//  Created by Jorge on 23/01/24.
//

import SwiftUI

struct CustomErrorMessageView: View {
    var message: String
    
    var body: some View {
        HStack {
            Text(message)
                .foregroundColor(.red)
            Spacer()
        }
    }
}

#Preview {
    CustomErrorMessageView(message: "Something went wrong")
}
