//
//  GroupManagementCustomNavBar.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 12/02/2026.
//

import SwiftUI

struct GroupManagementCustomNavBar: View {
    internal var body: some View {
        NavigationBar(
            isDisabled: false,
            start: 0,
            offset: -100,
            topPadding: 0
        ) {} center: {
            Text(Texts.Group.ManageSheet.title)
                .font(.system(size: 20, weight: .bold))
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .center)
        } trailing: {}
    }
}

#Preview {
    GroupManagementCustomNavBar()
}
