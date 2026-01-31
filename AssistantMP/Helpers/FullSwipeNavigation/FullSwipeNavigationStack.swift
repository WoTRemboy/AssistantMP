//
//  FullSwipeNavigationStack.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 31/01/2026.
//

import SwiftUI

struct FullSwipeNavigationStack<PathElement: Hashable, Content: View>: View {
    @Binding private var path: [PathElement]
    
    @ViewBuilder var content: Content
    
    @State private var customGesture: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer()
        gesture.name = UUID().uuidString
        gesture.isEnabled = false
        return gesture
    }()
    
    init(path: Binding<[PathElement]>, @ViewBuilder content: () -> Content) {
        self._path = path
        self.content = content()
    }

    init(@ViewBuilder content: () -> Content) {
        self._path = .constant([])
        self.content = content()
    }
    
    internal var body: some View {
        NavigationStack(path: $path) {
            content
                .background {
                    AttachGestureView(gesture: $customGesture)
                }
        }
        .environment(\.popGestureID, customGesture.name)
        .onReceive(NotificationCenter.default.publisher(for: .init(customGesture.name ?? ""))) { info in
            if let userInfo = info.userInfo, let status = userInfo["status"] as? Bool {
                customGesture.isEnabled = status
            }
        }
    }
}

extension View {
    @ViewBuilder
    func enableFillSwipePop(_ isEnabled: Bool) -> some View {
        self
            .modifier(FullSwipeModifier(isEnabled: isEnabled))
    }
}

#Preview {
    ContentView()
}
