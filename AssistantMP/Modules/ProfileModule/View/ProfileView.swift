//
//  ProfileView.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 23/01/2026.
//

import SwiftUI

struct ProfileView: View {
    
    private let user: User = .sample
    
    internal var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 16) {
                AccountInfoView(user: user)
                AccountBankView(user: user)
                AccountPropertyView()
            }
            .padding(.horizontal)
            .navigationBarHidden(true)
        }
        .safeAreaInset(edge: .top) {
            ProfileCustomNavBar()
        }
    }
}

#Preview {
    ProfileView()
}
