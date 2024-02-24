//
//  CustomShowDate.swift
//  todo-frontend
//
//  Created by Jorge on 25/01/24.
//

import SwiftUI

struct CustomShowDateView: View {
    
    var body: some View {
        Text(formatTodayDate())
            .foregroundColor(.white)
    }
    
    private func formatTodayDate() -> String {
        let todayDate = Date()
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "YY, MMM d"
        let dateString = dateFormatter.string(from: todayDate)
        
        return dateString
    }
}

#Preview {
    CustomShowDateView()
}
