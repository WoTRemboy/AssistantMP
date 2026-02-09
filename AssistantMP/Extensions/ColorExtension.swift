//
//  ColorExtension.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 20/01/2026.
//

import SwiftUI

extension Color {
    
    // MARK: - Back Colors
    
    enum Back {
        static let elevated = Color("BackElevated")
        static let iOSPrimary = Color("BackiOSPrimary")
        static let primary = Color("BackPrimary")
        static let secondary = Color("BackSecondary")
        static let backDefault = Color("BackDefault")
    }
    
    // MARK: - Label Colors
    
    enum Label {
        static let disable = Color("LabelDisable")
        static let details = Color("LabelDetails")
        static let primary = Color("LabelPrimary")
        static let secondary = Color("LabelSecondary")
        
        static let tertiary = Color("LabelTertiary")
        static let reversed = Color("LabelReversed")
        
        static let black = Color("LabelBlack")
        static let white = Color("LabelWhite")
        static let greyLight = Color("LabelGreyLight")
        static let greyDark = Color("LabelGreyDark")
        
        static let placeholder = Color("LabelPlaceholder")
    }
    
    // MARK: - Shadow Colors
    
    enum Shadow {
        static let popup = Color("ShadowPopup")
    }
}
