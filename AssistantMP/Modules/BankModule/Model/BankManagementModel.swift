//
//  BankManagementModel.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 02/02/2026.
//

import Foundation
import SwiftUI

enum BankManagement {
    case topUp
    case transfer
    
    internal var title: String {
        switch self {
        case .topUp:
            return Texts.Bank.topUp
        case .transfer:
            return Texts.Bank.transfer
        }
    }
    
    internal var image: Image {
        switch self {
        case .topUp:
            Image.Bank.coin
        case .transfer:
            Image.Bank.person
        }
    }
    
    internal var color: Color {
        switch self {
        case .topUp:
            Color.LabelColors.labelPrimary
        case .transfer:
            Color(.systemGray)
        }
    }
}
