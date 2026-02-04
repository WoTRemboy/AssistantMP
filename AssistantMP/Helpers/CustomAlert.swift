//
//  CustomAlert.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 02/02/2026.
//

import SwiftUI
import OSLog

private let logger = Logger(subsystem: "com.assistantmp.helpers", category: "CustomAlert")

extension View {
    @ViewBuilder
    func alert<Content: View, Background: View>(
        isPresented: Binding<Bool>,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder background: @escaping () -> Background
    ) -> some View {
        self.modifier(
            CustomAlertModifier(
                isPresented: isPresented,
                onDismiss: onDismiss,
                alertContent: content,
                background: background
            )
        )
    }
}

fileprivate struct CustomAlertModifier<AlertContent: View, Background: View>: ViewModifier {
    @Binding var isPresented: Bool
    var onDismiss: (() -> Void)?
    @ViewBuilder var alertContent: AlertContent
    @ViewBuilder var background: Background
    
    @State private var showFullScreenCover: Bool = false
    @State private var animatedValue: Bool = false
    @State private var allowsInteraction: Bool = false
    
    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $showFullScreenCover) {
                ZStack {
                    if animatedValue {
                        alertContent
                            .allowsHitTesting(allowsInteraction)
                    }
                }
                .presentationBackground {
                    background
                        .allowsHitTesting(allowsInteraction)
                        .opacity(animatedValue ? 1 : 0)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            guard allowsInteraction else { return }
                            isPresented = false
                        }
                }
                .task {
                    try? await Task.sleep(for: .seconds(0.05))
                    withAnimation(.easeInOut(duration: 0.2)) {
                        animatedValue = true
                    }
                    
                    try? await Task.sleep(for: .seconds(0.2))
                    allowsInteraction = true
                }
            }
            .onChange(of: isPresented) { oldValue, newValue in
                var transaction = Transaction()
                transaction.disablesAnimations = true
                
                if newValue {
                    withTransaction(transaction) {
                        showFullScreenCover = true
                    }
                } else {
                    onDismiss?()
                    allowsInteraction = false
                    withAnimation(.easeInOut(duration: 0.2), completionCriteria: .removed) {
                        animatedValue = false
                    } completion: {
                        withTransaction(transaction) {
                            showFullScreenCover = false
                        }
                    }
                }
            }
    }
}

struct CustomPaymentWarning: View {
    var title: String
    var content: String?
    var value: String?
    var titleError: String
    var image: Image
    var dismissAction: () -> Void
    
    @State private var text: String = ""
    var body: some View {
        VStack(spacing: 0) {
            image
                .resizable()
                .scaledToFit()
                .frame(width: 54, height: 54)
            
            Text(title)
                .font(.system(size: 18))
                .foregroundStyle(Color.LabelColors.labelPrimary)
                .multilineTextAlignment(.center)
                .padding(.top, 8)
            
            attributedTextLabel
                .font(.system(size: 18))
                .foregroundStyle(Color.LabelColors.labelPrimary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .padding(.horizontal, 16)
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.BackColors.primary)
        }
        .overlay(alignment: .topTrailing) {
            dismissButton
        }
        .padding(.horizontal, 24)
    }
    
    private var dismissButton: some View {
        Button {
            dismissAction()
        } label: {
            Image.Alert.dismiss
        }
        .buttonStyle(.plain)
        .contentShape(.rect)
        .padding(10)
    }
    
    private var attributedTextLabel: Text {
        if let attributedText = try? AttributedString(markdown: "\(content ?? "") **\(value ?? "")**") {
            return Text(attributedText)
        } else {
            logger.error("Attributed terms string creation failed from markdown.")
            return Text(titleError)
        }
    }
}
