//
//  DashboardViewModel.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 21/01/2026.
//

import Combine

final class DashboardViewModel: ObservableObject {
    
    @Published internal var selectedProperty: PropertyItem = .sample
    @Published internal var paymentAlertShow: Bool = false
    
    internal func paymentAlertShowToggle() {
        paymentAlertShow.toggle()
    }
}
