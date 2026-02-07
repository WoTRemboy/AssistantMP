//
//  GroupModels.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 05/02/2026.
//

import Foundation

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
