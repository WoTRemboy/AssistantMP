//
//  BankPaymentPopoverModel.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 03/02/2026.
//

import Foundation

struct PopoverIdentifiable: Identifiable, Hashable {
    let id = UUID()
    let category: PropertyCategory
    let item: PropertyItem
}
