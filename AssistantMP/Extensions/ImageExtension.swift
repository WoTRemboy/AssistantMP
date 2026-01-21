//
//  ImageExtension.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 20/01/2026.
//

import SwiftUI

extension Image {
    enum Dashboard {
        static let notification = Image("DashboardNotification")
        
        enum Sections {
            static let jobs = Image("DashboardTileJobs")
            static let games = Image("DashboardTileGames")
            static let friends = Image("DashboardTileFriends")
        }
    }
}
