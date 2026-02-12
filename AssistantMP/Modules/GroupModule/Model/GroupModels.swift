//
//  GroupModels.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 05/02/2026.
//

import Foundation
import SwiftUI

import SwiftUI

struct GroupMember: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let staticId: String
    let isOnline: OnlineStatus
    let unreadCount: Int
    
    enum OnlineStatus {
        case online
        case away
        case offline
        
        internal var color: Color {
            switch self {
            case .online: return .green
            case .away: return .yellow
            case .offline: return .secondary
            }
        }
    }
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

struct ManageGroupItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let count: Int
    let leadingIcon: ManageGroupIcon?
    let trailingIcon: ManageGroupIcon
    let category: GroupCategory?

    init(
        title: String,
        count: Int,
        leadingIcon: ManageGroupIcon?,
        trailingIcon: ManageGroupIcon,
        category: GroupCategory? = nil
    ) {
        self.title = title
        self.count = count
        self.leadingIcon = leadingIcon
        self.trailingIcon = trailingIcon
        self.category = category
    }

    init(
        category: GroupCategory,
        count: Int,
        leadingIcon: ManageGroupIcon?,
        trailingIcon: ManageGroupIcon
    ) {
        self.init(
            title: category.title,
            count: count,
            leadingIcon: leadingIcon,
            trailingIcon: trailingIcon,
            category: category
        )
    }
}

enum ManageGroupIcon {
    case pencil
    case trash
    case arrowRightSquare

    var image: Image {
        switch self {
        case .pencil:
            return Image.General.edit
        case .trash:
            return Image.General.trash
        case .arrowRightSquare:
            return Image.General.leave
        }
    }
}
