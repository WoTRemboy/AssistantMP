//
//  FullSwipeModifier.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 31/01/2026.
//

import SwiftUI

struct FullSwipeModifier: ViewModifier {
    @Environment(\.popGestureID) private var gestureID
    var isEnabled: Bool
    
    internal func body(content: Content) -> some View {
        content
            .onChange(of: isEnabled, initial: true) { oldValue, newValue in
                guard let gestureID = gestureID else { return }
                NotificationCenter.default.post(name: .init(gestureID), object: nil, userInfo: [
                    "status": newValue
                ])
            }
            .onDisappear {
                guard let gestureID = gestureID else { return }
                NotificationCenter.default.post(name: .init(gestureID), object: nil, userInfo: [
                    "status": false
                ])
            }
    }
}

extension EnvironmentValues {
    var popGestureID: String? {
        get {
            self[PopNotificationID.self]
        }
        set {
            self[PopNotificationID.self] = newValue
        }
    }
}


fileprivate struct PopNotificationID: EnvironmentKey {
    static var defaultValue: String?
}
