//
//  DateExtension.swift
//  AssistantMP
//
//  Created by Roman Tverdokhleb on 23/01/2026.
//

import Foundation

extension Date {
    static func makeDate(_ y: Int, _ m: Int, _ d: Int) -> Date {
        Calendar.current.date(from: DateComponents(year: y, month: m, day: d)) ?? Date()
    }
    
    static func daysUntil(_ date: Date) -> Int {
        let startOfToday = Calendar.current.startOfDay(for: Date())
        let startOfTarget = Calendar.current.startOfDay(for: date)
        let components = Calendar.current.dateComponents([.day], from: startOfToday, to: startOfTarget)
        return max(0, components.day ?? 0)
    }
    
    static func daysRemaining(until date: Date) -> String {
        let calendar = Calendar.autoupdatingCurrent
        let startOfToday = calendar.startOfDay(for: Date())
        let startOfTarget = calendar.startOfDay(for: date)
        if startOfTarget < startOfToday { return "0 days" }
        let interval = startOfTarget.timeIntervalSince(startOfToday)
        
        let formatter = DateComponentsFormatter()
        formatter.calendar = calendar
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.day]
        formatter.maximumUnitCount = 1
        formatter.includesApproximationPhrase = false
        formatter.includesTimeRemainingPhrase = false
        return formatter.string(from: interval) ?? "0 days"
    }
}

extension DateFormatter {
    static let shortPayment: DateFormatter = {
        let df = DateFormatter()
        df.locale = .autoupdatingCurrent
        df.timeZone = .autoupdatingCurrent
        df.dateStyle = .short
        df.timeStyle = .none
        return df
    }()
    
    static let shortTime: DateFormatter = {
        let df = DateFormatter()
        df.locale = .autoupdatingCurrent
        df.timeZone = .autoupdatingCurrent
        df.dateStyle = .none
        df.timeStyle = .short
        return df
    }()
    
    static let dayMonthYearTime: DateFormatter = {
        let df = DateFormatter()
        df.locale = .autoupdatingCurrent
        df.timeZone = .autoupdatingCurrent
        df.dateStyle = .short
        df.timeStyle = .short
        return df
    }()
}
