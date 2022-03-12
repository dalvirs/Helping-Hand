//
//  Validation.swift
//  FindServices
//
//  Created by Dalvir Singh on 2022-03-07.
//

import UIKit

class Validation {
    static func removeWhiteSpaces(_ str : UITextField) -> String? {
        return str.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    static func validateFields(_ str : UITextField) -> Bool {
        if removeWhiteSpaces(str) == "" {
            return false
        }
        return true
            
    }
}
