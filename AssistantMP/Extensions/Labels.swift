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
        enum Sections {
            static let jobs = "Coming Soon"
            static let games = "Coming Soon"
            static let friends = "Группы"
        }
        
        enum House {
            static let title = "Дом"
            static let more = "Ещё"
        }
    }
}
