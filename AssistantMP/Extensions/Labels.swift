//
//  Labels.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 20/01/2026.
//

import Foundation

final class Texts {
    
    // MARK: - App Info
    
    enum AppInfo {
        static let title = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? "Assistant"
    }
    
    enum Dashboard {
        static let more = "Ещё"
        
        enum Sections {
            static let jobs = "Coming Soon"
            static let games = "Coming Soon"
            static let friends = "Группы"
        }
        
        enum House {
            static let title = "Дом"
            
            enum Unlocked {
                static let title = "Открыто"
                static let action = "Закрыть"
            }
            
            enum Locked {
                static let title = "Закрыто"
                static let action = "Открыть"
            }
        }
        
        enum Bank {
            static let title = "Банк"
            static let action = "Перевести"
        }
    }
}
