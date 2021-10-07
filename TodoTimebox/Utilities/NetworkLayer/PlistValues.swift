//
//  PlistValues.swift
//  QueenlySwiftUI
//
//  Created by Irwin Gonzales on 6/11/21.
//

import Foundation

/// **PLIST VALUE READER FOR SAFETY**

class PlistValues {
    class func plistValues(bundle: Bundle) -> (String)? {
        guard
            let path = bundle.path(forResource: "Info", ofType: "plist"),
            let values = NSDictionary(contentsOfFile: path) as? [String: Any]
        else {
            print("Missing Config.plist file with 'TestBackendUrl', 'BackendUrl' & 'BaseBackendUrl' entries in main bundle!")
            return nil
        }

        guard
            let apiKey = values["ApiKey"] as? String
        else {
            print("Config.plist file at \(path) is missing 'TestBackendUrl','BackendUrl' and/or'BaseBackendUrl' entries!")
            print("File currently has the following entries: \(values)")
            return nil
        }
        return (apiKey)
    }
}
