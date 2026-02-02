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
                static let actionFull = "Закрыть дом"
            }
            
            enum Locked {
                static let title = "Закрыто"
                static let action = "Открыть"
                static let actionFull = "Открыть дом"
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
    
    enum Property {
        static let title = "Информация о доме"
        static let address = "Адрес"
        static let owner = "Владелец"
        static let status = "Статус дома"
        
        static let warning = "Внимание! Срок оплаты дома истекает через"
        static let warningShort = "Срок оплаты дома истекает через"
        static let warningError = "Посмотрите срок оплаты в разделе \"Дом\""
        
        static let deadline = "Срок оплаты"
        static let date = "Оплата истекает"
        static let remaining = "Осталось"
    }
    
    enum Bank {
        static let title = "Банковское приложение"
        static let titleShort = "Банк"
        static let balance = "Текущий баланс"
        
        static let topUp = "Пополнить"
        static let transfer = "Перевести"
        
        enum Transaction {
            static let title = "Последние транзакции"
            static let income = "Пополнение"
            static let transfer = "Перевод"
            static let housePayment = "Оплата дома"
        }
    }
}
