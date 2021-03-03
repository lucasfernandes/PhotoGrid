//
//  Message.swift
//  PhotoGrid (iOS)
//
//  Created by Lucas Silveira on 26/02/21.
//

import Foundation

enum MessageType {
    case success
    case error
}

enum MessageActionType: String {
    case added = "added"
    case deleted = "deleted"
}

struct Message: Identifiable {
    var id = UUID()
    var message: String
}

extension Message {
    static func generate(type: MessageType, action: MessageActionType) -> Message {
        switch type {
        case .success:
            return Message(message: "Photo \(action.rawValue) with success")
        case .error:
            return Message(message: "Oops... somehting went wrong.")
        }
    }
}
