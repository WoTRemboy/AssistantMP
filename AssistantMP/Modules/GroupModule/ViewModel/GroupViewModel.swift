//
//  GroupViewModel.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 05/02/2026.
//

import Foundation
import Combine
import SwiftUI

final class GroupViewModel: ObservableObject {
    @Published var selectedCategory: GroupCategory = .friends
    @Published var addMemberId: String = ""
    @Published var createdGroups: [ManageGroupItem] = [
        .init(category: .family, count: 3, leadingIcon: .pencil, trailingIcon: .trash),
        .init(title: "Братва", count: 5, leadingIcon: .pencil, trailingIcon: .trash)
    ]
    @Published var memberGroups: [ManageGroupItem] = [
        .init(category: .friends, count: 8, leadingIcon: nil, trailingIcon: .arrowRightSquare),
        .init(category: .work, count: 12, leadingIcon: nil, trailingIcon: .arrowRightSquare)
    ]

    var members: [GroupCategory: [GroupMember]] = GroupViewModel.sampleMembers

    var visibleMembers: [GroupMember] {
        members[selectedCategory] ?? []
    }

    var membersCountText: String {
        "\(Texts.Group.membersCount): \(visibleMembers.count)"
    }

    var createdTitleText: String {
        "Созданные мной группы: \(createdGroups.count)"
    }

    var memberTitleText: String {
        "Группы, в которых я состою: \(memberGroups.count)"
    }

    func addMember() {
        addMemberId = ""
    }

    func moveCreatedGroups(from source: IndexSet, to destination: Int) {
        createdGroups.move(fromOffsets: source, toOffset: destination)
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }

    func moveMemberGroups(from source: IndexSet, to destination: Int) {
        memberGroups.move(fromOffsets: source, toOffset: destination)
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
}

extension GroupViewModel {
    static let sampleMembers: [GroupCategory: [GroupMember]] = [
        .friends: [
            GroupMember(name: "Mike_Smith", staticId: "10042", status: .online, unreadCount: 1),
            GroupMember(name: "Alex_Johnson", staticId: "15678", status: .offline, unreadCount: 0),
            GroupMember(name: "Sarah_Williams", staticId: "23456", status: .away, unreadCount: 2),
            GroupMember(name: "David_Brown", staticId: "34567", status: .offline, unreadCount: 10),
            GroupMember(name: "Mike_Smith", staticId: "10042", status: .online, unreadCount: 0),
            GroupMember(name: "Alex_Johnson", staticId: "15678", status: .offline, unreadCount: 0)
        ],
        .work: [
            GroupMember(name: "Project_Team", staticId: "90001", status: .away, unreadCount: 0)
        ],
        .family: [
            GroupMember(name: "Anna_Smith", staticId: "44001", status: .offline, unreadCount: 5)
        ],
        .clan: [
            GroupMember(name: "Clan_Leader", staticId: "77777", status: .offline, unreadCount: 0)
        ]
    ]
}
