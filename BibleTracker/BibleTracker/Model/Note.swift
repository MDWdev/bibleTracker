//
//  Note.swift
//  BibleTracker
//
//  Created by Melissa Webster on 3/22/25.
//

import Foundation

class Note: NSObject {
    var content: String
    var timestamp: String
    var id: String
    
    override init() {
        content = ""
        timestamp = ""
        id = ""
        
        super.init()
    }
}
