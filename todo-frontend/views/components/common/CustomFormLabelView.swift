//
//  CustomFormLabelView.swift
//  todo-frontend
//
//  Created by Jorge on 21/01/24.
//

import SwiftUI

struct CustomFormLabelView: View {
    var label: String
    
    var body: some View {
        Text(label)
    }
}

#Preview {
    CustomFormLabelView(label: "Name")
}
