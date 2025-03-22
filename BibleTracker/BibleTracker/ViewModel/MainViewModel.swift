//
//  MainViewModel.swift
//  BibleTracker
//
//  Created by Melissa Webster on 3/22/25.
//

import UIKit

class MainViewModel: NSObject {
    let settingsService = SettingsService.shared
    let userService = UserService.shared
    let mainUser: Dynamic<UserInfo?>
    let nightModeOn: Dynamic<Bool>
    
    override init() {
        mainUser = Dynamic(nil)
        nightModeOn = Dynamic(false)
        
        super.init()
        
        userService.checkLoginState(completion: checkLoginResult(_:message:))
        
        settingsService.nightModeOn.bindAndFire { (onOff) in
            self.nightModeOn.value = onOff
        }
    }
    
    func checkLoginResult(_ user: UserInfo?, message: String) {
        if let user = user {
            mainUser.value = user
//            NotesService.shared.loadNotesLocally(completion: loadNotesLocallyResults(_:))
        }
    }
    
    @objc func checkUserAuth() {
        if let user = mainUser.value {
            userService.checkUserAuthString(user, completion: checkUserAuthResult(_:message:))
        }
    }
    
    func checkUserAuthResult(_ user: UserInfo?, message: String) {
        if user != nil {
            mainUser.value = user!
        }
        print(message)
    }
    
    func refreshUser() {
        userService.checkLoginState(completion: checkLoginResult(_:message:))
    }
    
    func updateUserLocally(_ userNew: UserInfo) {
        self.mainUser.value = userNew
    }
    
    func getCurrentUser() -> UserInfo? {
        return mainUser.value
    }
}
