//
//  NavigationBar.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 01/02/2026.
//

import SwiftUI

struct NavigationBar<Leading : View, Center : View, Trailing : View> : View {
    private let isDisabled: Bool
    private let start: CGFloat?
    private let offset: CGFloat?
    private let padding: CGFloat
    private let leading: Leading
    private let center: Center
    private let trailing: Trailing

    init(
        isDisabled: Bool = false,
        start: CGFloat? = nil,
        offset: CGFloat? = nil,
        topPadding: CGFloat = 0,
        @ViewBuilder leading: @escaping () -> Leading,
        @ViewBuilder center: @escaping () -> Center,
        @ViewBuilder trailing: @escaping () -> Trailing
    ) {
        self.isDisabled = isDisabled
        self.start      = start
        self.offset     = offset
        self.padding    = topPadding
        self.leading    = leading()
        self.center     = center()
        self.trailing   = trailing()
    }

    private let height: CGFloat = 50

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                leading
                    .frame(alignment: .leading)

                center
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .opacity(opacity)

                trailing
                    .frame(alignment: .trailing)
            }
            .frame(height: height)
            .padding(.top, padding)
            .padding(.horizontal)
            .clipped()
            .background(
                Color.BackColors.backDefault
            )
        }
    }

    var opacity: Double {
        guard !isDisabled else { return 0.0 }
        guard let start = start else { return 1.0 }
        guard let offset = offset else { return 1.0 }

        var currentOpacity = 0.0
        let distance = 24.0
        let increment = 1.0 / distance

        if offset < start {
            currentOpacity = increment * Double(-start - offset)
        }

        return currentOpacity > 1.0 ? 1.0 : currentOpacity
    }
}

// Leading optional.
extension NavigationBar where Leading == EmptyView, Center : View, Trailing : View {
    init(center: @escaping () -> Center, trailing: @escaping () -> Trailing) {
        self.init(leading: { EmptyView() }, center: center, trailing: trailing)
    }
}

// Trailing optional.
extension NavigationBar where Leading : View, Center : View, Trailing == EmptyView {
    init(leading: @escaping () -> Leading, center: @escaping () -> Center) {
        self.init(leading: leading, center: center, trailing: { EmptyView() })
    }
}

// Leading & Trailing optionals.
extension NavigationBar where Leading == EmptyView, Center : View, Trailing == EmptyView {
    init(
        isDisabled: Bool = false,
        start: CGFloat? = nil,
        offset: CGFloat? = nil,
        topPadding: CGFloat = 0,
        center: @escaping () -> Center
    ) {
        self.init(
            isDisabled: isDisabled,
            start: start,
            offset: offset,
            topPadding: topPadding,
            leading: { EmptyView() },
            center: center,
            trailing: { EmptyView() }
        )
    }
}

struct HeaderBottomPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = min(value, nextValue())
    }
}

#Preview {
    NavigationBar(
        isDisabled: false,
        start: 0,
        offset: 0,
        topPadding: 0
    ) {
        Image.Chevron.backward
    } center: {
        Text("Button")
    } trailing: {
        HStack(spacing: 16) {
            ForEach(NavbarAction.allCases, id: \.self) { type in
                IconCircleButton(type: type)
            }
        }
    }
}
