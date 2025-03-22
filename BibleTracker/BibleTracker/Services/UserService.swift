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
    
    func checkLoginState(completion: @escaping (UserInfo?, String) -> Void) {
        if let authUser = Auth.auth().currentUser {
            authUser.getIDTokenForcingRefresh(true) { (token, error) in
                if let token = token, error == nil {
                    let newUser = UserInfo()
                    newUser.authString = token
                    newUser.email = authUser.email ?? "unknown email"
                    
                    let userID = authUser.uid
                    if let _ = self.refDB, self.refUserID == userID {
                        
                    } else {
                        self.refUserID = userID
                        self.refDB = Database.database().reference(withPath: "user-data/\(self.refUserID!)")
                    }
                    
                    self.refDB!.observeSingleEvent(of: .value, with: { (snapshot) in
                        if let valueOut = snapshot.value as? [String:Any], let value = valueOut["profile"] as? [String:Any] {
                            newUser.firstName = value["first"] as? String ?? ""
                            newUser.lastName = value["last"] as? String ?? ""
                            
                            UserDefaults.standard.set("\(newUser.firstName)||\(newUser.lastName)", forKey: "name_info")
                        }
                        
                        completion(newUser, "Logged in")
                    }) { (error) in
                        print(error.localizedDescription)
                        completion(newUser, "Logged in")
                    }
                } else {
                    NetworkManager.isUnreachable { _ in
                        DispatchQueue.main.async {
                            let newUser = UserInfo()
                            newUser.authString = "offline"
                            if let nameCombo = UserDefaults.standard.value(forKey: "name_info") as? String {
                                let parts = nameCombo.components(separatedBy: "||")
                                if parts.count == 2 {
                                    newUser.firstName = parts[0]
                                    newUser.lastName = parts[1]
                                }
                            }
                            newUser.email = authUser.email ?? "unknown email"
                            completion(newUser, "Offline access")
                        }
                    }
                }
            }
        } else {
            completion(nil, "Not logged in")
        }
    }
    
    func checkUserAuthString(_ userIn: UserInfo, completion: @escaping (UserInfo?, String) -> Void) {
        if let authUser = Auth.auth().currentUser {
            authUser.getIDTokenForcingRefresh(false) { (token, error) in
                if let token = token, error == nil {
                    print(token)
                    userIn.authString = token
                    completion(userIn, "New Auth String")
                }
            }
        } else {
            completion(nil, "Not logged in: No Auth String")
        }
    }
    
    func deleteUser(_ userIn: UserInfo, completion: @escaping (Bool, String) -> Void) {
        if let authUser = Auth.auth().currentUser {
            authUser.delete { error in
                if let error = error {
                    completion(false, error.localizedDescription)
                } else {
                    self.refUserID = nil
                    completion(true, "User Deleted")
                }
            }
        } else {
            completion(false, "Not logged in: No Auth String")
        }
    }
    
    func loginWithEmail(_ email: String, password: String, completion: @escaping (UserInfo?, String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            print("Sign In Result:", authResult ?? "no auth", error ?? "no error")
            
            if let error = error {
                completion(nil, error.localizedDescription)
            } else if let authResult = authResult {
                authResult.user.getIDTokenForcingRefresh(false) { (token, error) in
                    if let token = token, error == nil {
                        
                        let newUser = UserInfo()
                        newUser.authString = token
                        newUser.email = authResult.user.email ?? "unknown email"
                        
                        let userID = authResult.user.uid
                        if let _ = self.refDB, self.refUserID == userID {
                            
                        } else {
                            self.refUserID = userID
                            self.refDB = Database.database().reference(withPath: "user-data/\(self.refUserID!)")
                        }
                        
                        self.refDB!.observeSingleEvent(of: .value, with: { (snapshot) in
                            var needsTerms = true
                            // Get user value
                            if let valueOut = snapshot.value as? [String:Any], let value = valueOut["profile"] as? [String:Any]  {
                                newUser.firstName = value["first"] as? String ?? ""
                                newUser.lastName = value["last"] as? String ?? ""
                                
                                UserDefaults.standard.set("\(newUser.firstName)||\(newUser.lastName)", forKey: "name_info")
                                
                                completion(newUser, "Logged in")
                            }
                        }) { (error) in
                            print(error.localizedDescription)
                            completion(newUser, "Logged in")
                        }
                    }
                }
            }
        }
    }
    
    func createUserWithEmail(_ email: String, password: String, first: String, last: String, completion: @escaping (UserInfo?, String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            print("Create User Result:", authResult ?? "no auth", error ?? "no error")
            
            if let error = error {
                completion(nil, error.localizedDescription)
            } else if let authResult = authResult {
                authResult.user.getIDTokenForcingRefresh(false) { (token, error) in
                    if let token = token, error == nil {
                        
                        let newUser = UserInfo()
                        newUser.authString = token
                        newUser.email = authResult.user.email ?? email
                        newUser.firstName = first
                        newUser.lastName = last

                        UserDefaults.standard.set("\(newUser.firstName)||\(newUser.lastName)", forKey: "name_info")
                        
                        let userID = authResult.user.uid
                        if let _ = self.refDB, self.refUserID == userID {
                            
                        } else {
                            self.refUserID = userID
                            self.refDB = Database.database().reference(withPath: "user-data/\(self.refUserID!)")
                        }
                        let dateStr = self.df.string(from: Date())
                        self.refDB!.child("profile").setValue(["source":"tracker","first":newUser.firstName, "last":newUser.lastName,"email":newUser.email,"created": dateStr])
                        
                        completion(newUser, "Created")
                    }
                }
            }
        }
    }
    
    func resetPasswordWithEmail(_ email: String, completion: @escaping (Bool, String) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error != nil {
                completion(false, error!.localizedDescription)
            } else {
                completion(true, "Check your email to reset your password")
            }
        }
    }
    
    func logout(completion: @escaping (Bool, String) -> Void) {
        do {
            try Auth.auth().signOut()
            
            self.refUserID = nil
            
            completion(true, "")
        } catch let signOutError as NSError {
            print ("Error signing out:", signOutError)
            
            completion(false, signOutError.localizedDescription)
        }
    }
    
    func updateUserData(_ userIn: UserInfo, first: String, last: String, newEmail: String?, confirmPW: String?, completion: @escaping (UserInfo?, String?) -> Void) {
        if var user = Auth.auth().currentUser {
            let userID = user.uid
            let credential = EmailAuthProvider.credential(withEmail: userIn.email, password: confirmPW ?? "")
            if let _ = self.refDB, self.refUserID == userID {
                
            } else {
                self.refUserID = userID
                self.refDB = Database.database().reference(withPath: "user-data/\(self.refUserID!)")
            }
            
            if newEmail != nil {
                user.reauthenticate(with: credential) { (result, error) in
                    if error != nil {
                        completion(nil, error!.localizedDescription)
                        return
                    }
                    
                    if result == nil {
                        completion(nil, "Could not reauthenticate user!")
                        return
                    }
                    
                    user = result!.user
                    
                    user.updateEmail(to: newEmail!) { (error) in
                        if error != nil {
                            completion(nil, error!.localizedDescription)
                            return
                        }
                        
                        self.loginWithEmail(newEmail!, password: confirmPW!, completion: { (user, msg) in
                            if user == nil {
                                completion(nil, msg)
                            } else {
                                self.refDB!.child("profile").child("first").setValue(first)
                                self.refDB!.child("profile").child("last").setValue(last)
                                self.refDB!.child("profile").child("email").setValue(newEmail!)
                                self.refDB!.child("profile").child("source").setValue("tracker")
                                
                                let newUser = UserInfo()
                                newUser.authString = userIn.authString
                                newUser.email = newEmail!
                                newUser.firstName = first
                                newUser.lastName = last
                                
                                UserDefaults.standard.set("\(newUser.firstName)||\(newUser.lastName)", forKey: "name_info")
                                
                                completion(newUser, nil)
                            }
                        })
                    }
                }
                return
            }
            
            self.refDB!.child("profile").child("first").setValue(first)
            self.refDB!.child("profile").child("last").setValue(last)
            self.refDB!.child("profile").child("source").setValue("tracker")
            
            let newUser = UserInfo()
            newUser.authString = userIn.authString
            newUser.email = userIn.email
            newUser.firstName = first
            newUser.lastName = last
            
            UserDefaults.standard.set("\(newUser.firstName)||\(newUser.lastName)", forKey: "name_info")
            completion(newUser, nil)
            
            return
        }
        
        completion(nil, nil)
    }
    
    func removeAllData(completion: @escaping (Bool) -> Void) {
        if let user = Auth.auth().currentUser {
            let userID = user.uid
            self.refUserID = userID
            self.refDB = Database.database().reference(withPath: "user-data/\(self.refUserID!)")
            
            self.refDB?.removeValue(completionBlock: { err, ref in
                if let err = err {
                    print(err)
                    completion(false)
                } else {
                    completion(true)
                }
            })
        }
    }
}


