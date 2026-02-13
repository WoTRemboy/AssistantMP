//
//  ChatMessageModel.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 13/02/2026.
//

import Foundation
import SwiftUI

struct ChatMessage {
    let text: String
    let time: String
    let isOutgoing: Bool
    let showsStatus: Bool

    var isEmojiOnly: Bool {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return false }
        let scalars = trimmed.unicodeScalars
        let emojiScalars = scalars.filter { $0.properties.isEmojiPresentation || $0.properties.isEmoji }
        return emojiScalars.count == scalars.count
    }
    
    static internal let sampleList: [ChatMessage] = [
        .init(text: "Новое сообщение", time: "15:54", isOutgoing: true, showsStatus: true),
        .init(text: "Новое", time: "15:54", isOutgoing: false, showsStatus: false),
        .init(text: "Максимальная длина сообщения в\n2 строки 😅", time: "15:55", isOutgoing: false, showsStatus: false),
        .init(text: "🤣", time: "15:54", isOutgoing: true, showsStatus: true),
        .init(text: "Отлично", time: "15:54", isOutgoing: false, showsStatus: false),
        .init(text: "🤣", time: "15:54", isOutgoing: false, showsStatus: false)
    ]
        
}

struct ChatBubbleStyle {
    let background: Color
    let textColor: Color
    let timeColor: Color

    static let outgoing = ChatBubbleStyle(
        background: Color(.systemGray),
        textColor: Color.white,
        timeColor: Color.white.opacity(0.7)
    )

    static let incoming = ChatBubbleStyle(
        background: Color.white,
        textColor: Color.black,
        timeColor: Color(.systemGray2)
    )
}
