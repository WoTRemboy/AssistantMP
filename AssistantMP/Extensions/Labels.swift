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
        static let wallet = "Пополнить баланс"
        
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
        
        enum Market {
            static let title = "Маркетплейс"
            static let count = "шт."
            
            static let general = "Основные"
            static let sale = "Свои"
            
            static let active = "Активно"
            static let expired = "Истекает"
            static let sold = "Продано"
        }
        
        enum Referal {
            static let title = "Реферальная программа"
            static let link = "Поделиться ссылкой"
        }
        
        enum Security {
            static let title = "Настройки безопасности"
            static let password = "Смена пароля"
            static let twoFactor = "2FA"
        }
    }
    
    enum Profile {
        static let xp = "Опыт"
        static let level = "Уровень"
        static let bank = "Банк"
        static let cash = "Наличные"
        
        enum Property {
            static let title = "Имущество"
            static let payment = "Оплата"
            static let home = "Дом"
            static let business = "Бизнес"
            static let transport = "Транспорт"
        }
    }
}
