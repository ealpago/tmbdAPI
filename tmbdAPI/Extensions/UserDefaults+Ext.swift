//
//  UserDefaults+Ext.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 29.06.2023.
//

import Foundation

enum UserDefaultsKeys: String {
    case loggedUser = "loggedUser"
    case user = "user"
    case password = "password"
}

extension UserDefaults {

    class func clearAll() {
        self.standard.dictionaryRepresentation().keys.forEach {key in
            self.standard.removeObject(forKey: key)
        }
    }

    class var loggedUser: LoggedUser? {
        get {
            guard let data = standard.value(forKey: UserDefaultsKeys.loggedUser.rawValue) as? Data else {return nil}
            return try? JSONDecoder().decode(LoggedUser.self, from: data)
        }set {
            if newValue == nil {
                standard.removeObject(forKey:  UserDefaultsKeys.loggedUser.rawValue)
                standard.synchronize()
            }else {
                guard let data = try? JSONEncoder().encode(newValue) else {return}
                standard.set(data, forKey: UserDefaultsKeys.loggedUser.rawValue)
                standard.synchronize()
            }
        }
    }

    class var user:String? {
        get {
            return standard.string(forKey: UserDefaultsKeys.user.rawValue)
        }
        set {
            if newValue == nil {
                standard.removeObject(forKey: UserDefaultsKeys.user.rawValue)
                standard.synchronize()
            }else {
                standard.set(newValue, forKey: UserDefaultsKeys.user.rawValue)
                standard.synchronize()
            }
        }
    }
}
