//
//  ColorExtension.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 20/01/2026.
//

import SwiftUI

extension Color {
    
    // MARK: - Back Colors
    
    enum BackColors {
        static let elevated = Color("BackElevated")
        static let iOSPrimary = Color("BackiOSPrimary")
        static let primary = Color("BackPrimary")
        static let secondary = Color("BackSecondary")
        static let backDefault = Color("BackDefault")
    }
    
    // MARK: - Label Colors
    
    enum LabelColors {
        static let labelDisable = Color("LabelDisable")
        static let labelDetails = Color("LabelDetails")
        static let labelPrimary = Color("LabelPrimary")
        static let labelSecondary = Color("LabelSecondary")
        
        static let labelTertiary = Color("LabelTertiary")
        static let labelReversed = Color("LabelReversed")
        
        static let labelBlack = Color("LabelBlack")
        static let labelWhite = Color("LabelWhite")
        static let labelGreyLight = Color("LabelGreyLight")
        static let labelGreyDark = Color("LabelGreyDark")
        
        static let labelPlaceholder = Color("LabelPlaceholder")
    }
}
