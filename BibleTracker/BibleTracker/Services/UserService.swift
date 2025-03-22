//
//  UserService.swift
//  BibleTracker
//
//  Created by Melissa Webster on 3/22/25.
//

import Foundation
import Firebase
import FirebaseAnalytics
import FirebaseDatabase
import FirebaseAuth

class UserService: NSObject {
    static let shared = UserService()
    
    let deleteInProcess: Dynamic<Bool>
    let deleteSuccess: Dynamic<Bool>
    
    private var refDB: DatabaseReference?
    private var refUserID: String?
    private let df = DateFormatter()
    
    private override init() {
        print("UserService initialized")
        
        deleteInProcess = Dynamic(false)
        deleteSuccess = Dynamic(false)
        
        df.dateFormat = "yyyy-MM-dd HH:mm:ss zzz"
    }
    
    
}


