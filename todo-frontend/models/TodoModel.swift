//
//  TodoModel.swift
//  todo-frontend
//
//  Created by Jorge on 16/01/24.
//

import Foundation

struct NewTodo: Codable {
    var name: String
    var description: String
}

struct TodoErrors: Codable {
    var name: [String]?
    var description: [String]?
}
