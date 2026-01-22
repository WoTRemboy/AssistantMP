//
//  NavbarActionModel.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 22/01/2026.
//

import SwiftUI

enum NavbarAction: CaseIterable {
    case gift
    case bank
    case settings
    
    internal var icon: Image {
        switch self {
        case .gift:
            Image.Navbar.gift
        case .bank:
            Image.Navbar.bank
        case .settings:
            Image.Navbar.settings
        }
    }
}
