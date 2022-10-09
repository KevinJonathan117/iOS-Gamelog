//
//  LocalStorage.swift
//  Gamelog
//
//  Created by Kevin Jonathan on 09/10/22.
//

import Foundation

class LocalStorage {
    static private let userDefaults = UserDefaults.standard
    
    static func setValue(key: String, value: String) {
        userDefaults.set(value, forKey: key)
    }
    
    static func getValue(key: String) -> String? {
        return userDefaults.string(forKey: key)
    }
    
    static func initDefaultProfileInfo() {
        guard getValue(key: "name") == nil,
              getValue(key: "job") == nil,
              getValue(key: "aboutMe") == nil else {
            return
        }
        
        setValue(key: "name", value: "Kevin Jonathan")
        setValue(key: "job", value: "Associate Mobile Development Engineer (iOS) at Blibli.com")
        setValue(key: "aboutMe", value: "I am Kevin Jonathan, an ambitious mobile development engineer proficient in iOS app development and Flutter. I have 4+ years of experience in mobile application engineering and 10 months of internship in Apple Developer Academy @UC.\n\nI am currently working as an iOS Developer at Blibli.com. Kindly connect with me!")
    }
}
