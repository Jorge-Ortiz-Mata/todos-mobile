//
//  TodoModel.swift
//  todo-frontend
//
//  Created by Jorge on 16/01/24.
//

import Foundation

struct TodosModel: Codable {
    var todos: String
}

struct TodoModel: Identifiable, Codable {
    var id: Int
    var name: String
    var description: String
    var date: String
}

struct NewTodo: Codable {
    var name: String
    var description: String
    var date: String
}

struct TodoErrors: Codable {
    var name: [String]?
    var description: [String]?
    var date: [String]?
}
