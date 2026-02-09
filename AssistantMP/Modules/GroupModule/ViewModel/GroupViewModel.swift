//
//  GroupViewModel.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 05/02/2026.
//

import Foundation
import Combine

final class GroupViewModel: ObservableObject {
    @Published var selectedCategory: GroupCategory = .friends
    @Published var addMemberId: String = ""

    var members: [GroupCategory: [GroupMember]] = GroupViewModel.sampleMembers

    var visibleMembers: [GroupMember] {
        members[selectedCategory] ?? []
    }

    var membersCountText: String {
        "\(Texts.Group.membersCount): \(visibleMembers.count)"
    }

    func addMember() {
        addMemberId = ""
    }
}

extension GroupViewModel {
    static let sampleMembers: [GroupCategory: [GroupMember]] = [
        .friends: [
            GroupMember(name: "Mike_Smith", staticId: "10042", isOnline: .online, unreadCount: 1),
            GroupMember(name: "Alex_Johnson", staticId: "15678", isOnline: .offline, unreadCount: 0),
            GroupMember(name: "Sarah_Williams", staticId: "23456", isOnline: .away, unreadCount: 2),
            GroupMember(name: "David_Brown", staticId: "34567", isOnline: .offline, unreadCount: 10),
            GroupMember(name: "Mike_Smith", staticId: "10042", isOnline: .online, unreadCount: 0),
            GroupMember(name: "Alex_Johnson", staticId: "15678", isOnline: .offline, unreadCount: 0)
        ],
        .work: [
            GroupMember(name: "Project_Team", staticId: "90001", isOnline: .away, unreadCount: 0)
        ],
        .family: [
            GroupMember(name: "Anna_Smith", staticId: "44001", isOnline: .offline, unreadCount: 5)
        ],
        .clan: [
            GroupMember(name: "Clan_Leader", staticId: "77777", isOnline: .offline, unreadCount: 0)
        ]
    ]
}
