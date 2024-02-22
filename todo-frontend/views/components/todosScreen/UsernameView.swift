//
//  UsernameView.swift
//  todo-frontend
//
//  Created by Jorge on 16/01/24.
//

import SwiftUI

struct UsernameView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Hola Jorge!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                Image(systemName: "hand.wave.fill")
                    .font(.title2)
                    .foregroundColor(.yellow)
                Spacer()
            }
            
            HStack {
                Text(currentDate())
                    .fontWeight(.light)
                    .foregroundStyle(.black)
                Spacer()
            }
        }
        .padding(.bottom, 20)
    }
    
    private func currentDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: date)
        
        if(formattedDate.count > 0) {
            let dateSplitted = formattedDate.components(separatedBy: "-")
            let months: [String] = ["", "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]
            
            guard let month = Int(dateSplitted[1]) else { return "Error" }
            let monthName = months[month]
            
            let dateReadble = "\(dateSplitted[2]) \(monthName), \(dateSplitted[0])"
            
            return dateReadble
        }
        
        return ""
    }
}

#Preview {
    UsernameView()
}
