//
//  AppInfo.swift
//  todo-frontend
//
//  Created by Jorge on 20/02/24.
//

import SwiftUI

struct AppInfo: View {
    var body: some View {
        VStack {
            HStack {
                Text("Bienvenido a DoTask")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
            }
            .padding(.bottom,  10)
            
            HStack {
                Text("Muchas gracias por escoger DoTask! DoTask te ayudara a organizar tus actividades de manera eficiente y ordenada :D")
                    .multilineTextAlignment(.center)
                    .fontWeight(.light)
                    .foregroundStyle(.black)
            }
        }
    }
}

#Preview {
    AppInfo()
}
