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
            VStack {
                Image("todo-no-back")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .background(.white)
                .cornerRadius(200)
            }
            .padding(.bottom, 20)
            
            HStack {
                Text("Añade actividades y mantente al tanto de ellas")
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
            }
            .padding(.bottom,  10)
            
            HStack {
                Text("Maneja y organiza tus actividades de manera eficaz y rapida")
                    .multilineTextAlignment(.center)
                    .fontWeight(.light)
                    .foregroundStyle(grayColor)
            }
        }
    }
}

#Preview {
    AppInfo()
}
