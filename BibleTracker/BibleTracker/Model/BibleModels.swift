//
//  BibleModels.swift
//  BibleTracker
//
//  Created by Melissa Webster on 3/22/25.
//

import Foundation

struct BibleTranslation: Codable, Equatable {
    var translation: String
    var lastModified: String
    var info: TranslationInfo?
    
    enum CodingKeys: String, CodingKey {
        case translation
        case lastModified = "last_modified"
    }
    
    static func ==(lhs: BibleTranslation, rhs: BibleTranslation) -> Bool {
        return lhs.translation == rhs.translation && lhs.lastModified == rhs.lastModified
    }
}

struct BibleBook: Codable {
    var display: String
    var chapters: Int
    var verses: [Int]
    var order: Int
    var testament: String
    var osis: String
}

struct TranslationAttribution: Codable {
    var translation: String
    var translationName: String
    var copyDate: String?
    var copyOwner: String?
    var versionInfo: String?
    var copyShort: String?
    var copyLong: String?
    var languageIso: String?
    var languageDisplay: String?
    var lastModified: String?
    var downloadableUntil: String?
    var downloadPrereq: String?
    
    enum CodingKeys: String, CodingKey {
        case translation
        case translationName = "translation_name"
        case copyDate = "copy_date"
        case copyOwner = "copy_owner"
        case versionInfo = "version_info"
        case copyShort = "copy_short"
        case copyLong = "copy_long"
        case languageIso = "lanugage_iso"
        case languageDisplay = "lanugage_display"
        case lastModified = "last_modified"
        case downloadableUntil = "downloadable_until"
        case downloadPrereq = "download_prerequisite"
    }
}

struct BiblePassage: Codable {
    var content: String
    var footnotes: [String]?
    var crossrefs: [String]?
    var reference: String
    var attribution: PassageAttribution?
    var audio: PassageAudio?
}

struct PassageAttribution: Codable {
    var copyDate: String
    var copyShort: String
    var translation: String
    var translationName: String
    
    enum CodingKeys: String, CodingKey {
        case copyDate = "copy_date"
        case copyShort = "copy_short"
        case translation
        case translationName = "translation_name"
    }
}

struct PassageAudioData: Codable {
    var reader: String
    var copyright: String
    var mp3: String?
    var ogg: String?
    var htmlPlayer: String?
    
    enum CodingKeys: String, CodingKey {
        case reader
        case copyright
        case mp3
        case ogg
        case htmlPlayer = "html_player"
    }
}

struct PassageAudio: Codable {
    var pData: [PassageAudioData]
    
    enum CodingKeys: String, CodingKey {
        case pData = "data"
    }
}

struct TranslationsRequestResponse: Codable {
    var tData: [BibleTranslation]?
    
    enum CodingKeys: String, CodingKey {
        case tData = "data"
    }
}

struct TranslationInfoRequestResponse: Codable {
    var tData: [TranslationInfo]?
    
    enum CodingKeys: String, CodingKey {
        case tData = "data"
    }
}

struct TranslationInfo: Codable {
    var attribution: TranslationAttribution
    var books: [BibleBook]
}

struct PassageRequestResponse: Codable {
    var tData: [ReferenceResponse]?
    
    enum CodingKeys: String, CodingKey {
        case tData = "data"
    }
}

struct ReferenceResponse: Codable {
    var osis: String
    var passages: [BiblePassage]?
}

class VerseOfDay: NSObject {
    var title: String?
    var desc: String?
    var link: String?
    var content: String?
}
