//
//  ImageExtension.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 20/01/2026.
//

import SwiftUI

extension Image {
    enum Opening {
        static let logo = Image("SplashScreenLogo")
    }
    
    enum Dashboard {
        static let notification = Image("DashboardNotification")
        static let info = Image("DashboardInfo")
        
        enum Sections {
            static let jobs = Image("DashboardTileJobs")
            static let games = Image("DashboardTileGames")
            static let friends = Image("DashboardTileFriends")
        }
        
        enum House {
            static let locked = Image("DashboardHouseLocked")
            static let unlocked = Image("DashboardHouseUnlocked")
        }
        
        enum Market {
            static let active = Image("DashboardMarketActiveStatus")
            static let expiring = Image("DashboardMarketExpiringStatus")
            static let sold = Image("DashboardMarketSoldStatus")
            static let remove = Image("DashboardMarketRemovePosition")
        }
    }
}
