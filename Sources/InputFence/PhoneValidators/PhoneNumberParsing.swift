//
//  PhoneNumberParsing.swift
//  InputFence
//
//  Created by Agustin D. Palmeira on 15/07/2026.
//

protocol PhoneNumberParsing {
    func canParse(_ value: String, region: String) -> Bool
}
