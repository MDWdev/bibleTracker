//
//  ContainersViewModel.swift
//  BibleTracker
//
//  Created by Melissa Webster on 3/22/25.
//

import Foundation

class ContainersViewModel: NSObject {
    let mainUser: Dynamic<UserInfo?>
    
    init(withUser: UserInfo?) {
        self.mainUser = Dynamic(withUser)
        
        super.init()
    }
    
    func update(user: UserInfo?) {
        self.mainUser.value = user
    }
    
    func getCurrentUser() -> UserInfo? {
        return mainUser.value
    }
}
