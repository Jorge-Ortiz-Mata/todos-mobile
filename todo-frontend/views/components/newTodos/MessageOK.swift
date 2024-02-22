//
//  MessageOK.swift
//  todo-frontend
//
//  Created by Jorge on 21/02/24.
//

import SwiftUI

struct MessageOK: View {
    var body: some View {
        VStack {
            Image(systemName: "checkmark.circle")
                .font(.system(size: 60))
                .foregroundColor(.green)
            
            Text("Actividad creada!")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.bottom, 10)
                .foregroundStyle(.black)
            
            Text("Tu nueva activada ha sido creada existosamente.")
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    MessageOK()
}
