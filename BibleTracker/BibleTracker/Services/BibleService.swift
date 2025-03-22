//
//  BibleService.swift
//  BibleTracker
//
//  Created by Melissa Webster on 3/22/25.
//

import Foundation

let gatewayDomain = "https://api.biblegateway.com/3/bible"
let poweredByLink = "https://www.biblegateway.com/"

class BibleService: NSObject {
    static let shared = BibleService()
    
    private var lastTranslations: [BibleTranslation]?
    private var lastTranslationsLoad: Date?
    
    private var infoCount: Int = 0
    private var totalInfo: Int?
    
    let infoLoaded: Dynamic<Bool>
    
    var currentElement:String?
    var currentValue:String?
    var currentItem:NSMutableDictionary?
    var lastItem: VerseOfDay?
    
    var token = ""
    
    private override init() {
        print("Bible Services initialized")
        infoLoaded = Dynamic(false)
        super.init()
        
        if let lastToken = UserDefaults.standard.value(forKey: "biblegateway_token") as? String {
            token = lastToken
        }
        
//        self.getUserToken()
    }
}
