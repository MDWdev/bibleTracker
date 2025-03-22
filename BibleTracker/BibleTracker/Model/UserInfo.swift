//
//  UserInfo.swift
//  BibleTracker
//
//  Created by Melissa Webster on 3/22/25.
//

import Foundation

class UserInfo: NSObject {
    var authString: String
    var email: String
    var firstName: String
    var lastName: String
    
    override init() {
        authString = ""
        email = ""
        firstName = ""
        lastName = ""
        
        super.init()
    }
}
