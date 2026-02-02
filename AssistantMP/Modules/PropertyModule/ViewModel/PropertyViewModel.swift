//
//  PropertyViewModel.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 02/02/2026.
//

import Combine

final class PropertyViewModel: ObservableObject {
    
    @Published internal var selectedProperty: PropertyItem = .sampleList[0]
    @Published internal var showAddressPicker: Bool = false
    
    internal let properties: [PropertyItem] = PropertyItem.sampleList
    
    init() {
        self.selectedProperty = properties[0]
    }

    internal func showAddressPickerToggle() {
        showAddressPicker.toggle()
    }
    
    internal func lockStatusToggle() {
        selectedProperty.lockStatus?.toggle()
    }
}
