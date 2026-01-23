//
//  ProfileView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 23/01/2026.
//

import SwiftUI

struct ProfileView: View {
    internal var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 16) {
                AccountInfoView(user: .sample)
                AccountBankView(user: .sample)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ProfileView()
}
