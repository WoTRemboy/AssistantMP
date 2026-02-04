//
//  GroupModels.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 05/02/2026.
//

import Foundation

struct GroupMember: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let staticId: String
    let isOnline: Bool
    let unreadCount: Int
}

enum GroupCategory: CaseIterable, Hashable {
    case friends
    case work
    case family
    case clan

    var title: String {
        switch self {
        case .friends: return Texts.Group.Tab.friends
        case .work: return Texts.Group.Tab.work
        case .family: return Texts.Group.Tab.family
        case .clan: return Texts.Group.Tab.clan
        }
    }

    var showsNotification: Bool {
        switch self {
        case .friends, .family:
            return true
        case .work, .clan:
            return false
        }
    }
}
