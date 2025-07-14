//
//  Item.swift
//  test
//
//  Created by Rob Mihalko on 2025/07/13.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
