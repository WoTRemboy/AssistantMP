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
    
    enum Navbar {
        static let gift = Image("NavbarGift")
        static let bank = Image("NavbarBank")
        static let settings = Image("NavbarSettings")
    }
    
    enum Chevron {
        static let forward = Image("ChevronForward")
        static let backward = Image("ChevronBackward")
    }
    
    enum Dashboard {
        static let notification = Image("DashboardNotification")
        static let info = Image("DashboardInfo")
        static let currency = Image("DashboardCurrency")
        
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
        
        enum Referal {
            static let share = Image("DashboardReferalLink")
        }
    }
    
    enum Profile {
        static let placeholder = Image("ProfileIconPlaceholder")
        static let edit = Image("ProfileNameEdit")
    }
}
