//
//  GroupChatView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 11/02/2026.
//

import SwiftUI

struct GroupChatView: View {
    @Environment(\.dismiss) private var dismiss
    let member: GroupMember

    @State private var inputText = ""
    @State private var messages: [ChatMessage] = ChatMessage.sampleList

    internal var body: some View {
        VStack(spacing: 0) {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 12) {
                    datePill(Texts.Group.Chat.today)

                    ForEach(messages.indices, id: \.self) { index in
                        if index == 3 {
                            unreadPill(Texts.Group.Chat.unread)
                        }
                        messageRow(messages[index])
                    }
                }
                .frame(alignment: .bottom)
                .padding(.horizontal, 16)
                .padding(.top, 12)
            }
        }
        .background(Color(.systemGray5))
        .safeAreaInset(edge: .top) {
            GroupChatCustomNavBar(member: member)
        }
        .safeAreaInset(edge: .bottom) {
            inputBar
        }
        .navigationBarHidden(true)
        .enableFillSwipePop(true)
    }

    private var inputBar: some View {
        let hasText = !inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        
        return HStack(alignment: .bottom, spacing: 12) {
            TextField(Texts.Group.Chat.placeholder, text: $inputText, axis: .vertical)
                .font(.system(size: 17, weight: .regular))
                .foregroundStyle(Color.Label.primary)
                .lineLimit(3)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color(.systemGray4))
                )

            if hasText {
                Button {
                    sendMessage()
                } label: {
                    Image.Group.sendMessage
                }
                .buttonStyle(.plain)
                .transition(.scale.combined(with: .opacity))
            }
        }
        .animation(.easeInOut(duration: 0.2), value: hasText)
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(Color.Back.backDefault)
    }

    private func sendMessage() {
        let trimmed = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        let time = DateFormatter.shortTime.string(from: .now)
        messages.append(.init(text: trimmed, time: time, isOutgoing: true, showsStatus: true))
        inputText = ""
        hideKeyboard()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            let replyText = trimmed.contains("?") ? "Отлично" : "🤣"
            let replyTime = DateFormatter.shortTime.string(from: .now)
            messages.append(.init(text: replyText, time: replyTime, isOutgoing: false, showsStatus: false))
        }
    }

    private func messageRow(_ message: ChatMessage) -> some View {
        HStack {
            if message.isOutgoing {
                Spacer(minLength: 120)
                messageContent(message, style: .outgoing)
            } else {
                messageContent(message, style: .incoming)
                Spacer(minLength: 120)
            }
        }
    }

    private func messageContent(_ message: ChatMessage, style: ChatBubbleStyle) -> some View {
        if message.isEmojiOnly {
            return AnyView(emojiRow(message, style: style))
        }
        return AnyView(messageBubble(message, style: style))
    }

    private func messageBubble(_ message: ChatMessage, style: ChatBubbleStyle) -> some View {
        HStack(alignment: .bottom, spacing: 4) {
            Text(message.text)
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(style.textColor)
                .fixedSize(horizontal: false, vertical: true)

            HStack(spacing: 4) {
                Text(message.time)
                    .font(.system(size: 11, weight: .regular))
                    .foregroundStyle(style.timeColor)

                if message.showsStatus {
                    Image(systemName: "checkmark")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(style.timeColor)
                }
            }
            .offset(y: 6)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(style.background)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }

    private func emojiRow(_ message: ChatMessage, style: ChatBubbleStyle) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(message.text)
                .font(.system(size: 28))

            emojiStatusPill(message, style: style)
        }
        .padding(.horizontal, 4)
    }

    private func emojiStatusPill(_ message: ChatMessage, style: ChatBubbleStyle) -> some View {
        HStack(spacing: 4) {
            Text(message.time)
                .font(.system(size: 11, weight: .regular))
                .foregroundStyle(style.timeColor)

            if message.showsStatus {
                Image(systemName: "checkmark")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundStyle(style.timeColor)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(
            Capsule()
                .fill(Color.white)
        )
    }

    private func datePill(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 12, weight: .regular))
            .foregroundStyle(Color.Label.secondary)
            .padding(.horizontal, 12)
            .padding(.vertical, 4)
            .background(
                Capsule()
                    .fill(Color.white)
            )
    }

    private func unreadPill(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 12, weight: .regular))
            .foregroundStyle(Color.Label.secondary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 4)
            .background(
                Capsule()
                    .fill(Color.white)
            )
    }
}

#Preview {
    GroupChatView(member: .init(name: "Mike_Smith", staticId: "123", status: .online, unreadCount: 2))
        .environmentObject(AppRouter())
}
