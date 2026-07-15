//
//  DateProviding.swift
//  InputFence
//
//  Created by Agustin D. Palmeira on 15/07/2026.
//

import Foundation

protocol DateProviding {
    var now: Date { get }
}

struct SystemDateProvider: DateProviding {
    var now: Date {
        Date()
    }
}
