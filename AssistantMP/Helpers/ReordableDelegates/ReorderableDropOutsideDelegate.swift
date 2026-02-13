//
//  ReorderableDropOutsideDelegate.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 11/02/2026.
//

import SwiftUI

struct ReorderableDropOutsideDelegate<Item: Reorderable>: DropDelegate {
    
    @Binding
    var active: Item?
        
    func dropUpdated(info: DropInfo) -> DropProposal? {
        DropProposal(operation: .move)
    }
    
    func performDrop(info: DropInfo) -> Bool {
        active = nil
        return true
    }
}
