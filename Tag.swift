//
//  Tag.swift
//  Banker Collab App
//
//  Created by T Krobot on 12/9/22.
//

import Foundation
import SwiftUI

struct Tag: Identifiable {
    var id = UUID()
    var name: String
    var icon: String
    var colour: Color
}
