//
//  PhoneNumberKitParser.swift
//  InputFence
//
//  Created by Agustin D. Palmeira on 15/07/2026.
//

import PhoneNumberKit

struct PhoneNumberKitParser: PhoneNumberParsing {
    private let phoneNumberKit = PhoneNumberKit()

    func canParse(_ value: String, region: String) -> Bool {
        do {
            _ = try phoneNumberKit.parse(value, withRegion: region, ignoreType: true)
            return true
        } catch {
            return false
        }
    }
}
