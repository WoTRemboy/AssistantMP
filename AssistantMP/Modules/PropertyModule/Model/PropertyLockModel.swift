//
//  PropertyLockModel.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 21/01/2026.
//

import SwiftUI

enum PropertyLock {
    case locked
    case unlocked
    
    internal var title: String {
        switch self {
        case .locked:
            Texts.Dashboard.House.Locked.title
        case .unlocked:
            Texts.Dashboard.House.Unlocked.title
        }
    }
    
    internal var actionTitle: String {
        switch self {
        case .locked:
            Texts.Dashboard.House.Locked.action
        case .unlocked:
            Texts.Dashboard.House.Unlocked.action
        }
    }
    
    internal var actionTitleFull: String {
        switch self {
        case .locked:
            Texts.Dashboard.House.Locked.actionFull
        case .unlocked:
            Texts.Dashboard.House.Unlocked.actionFull
        }
    }
    
    internal var icon: Image {
        switch self {
        case .locked:
            Image.Dashboard.House.locked
        case .unlocked:
            Image.Dashboard.House.unlocked
        }
    }
    
    internal var color: Color {
        switch self {
        case .locked: .green
        case .unlocked: .red
        }
    }
    
    internal mutating func toggle() {
        switch self {
        case .locked:
            self = .unlocked
        case .unlocked:
            self = .locked
        }
    }
}
