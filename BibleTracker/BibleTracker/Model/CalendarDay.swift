//
//  CalendarDay.swift
//  BibleTracker
//
//  Created by Melissa Webster on 3/22/25.
//

import Foundation

class CalendarDay: NSObject {
    var num: String = ""
    var isComplete: Bool = false
    var hasNotes: Bool = false
    var isHighlighted: Bool = false
    var fullDay: Date?
}
