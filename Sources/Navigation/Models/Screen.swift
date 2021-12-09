//
//  File.swift
//  
//
//  Created by Ivan Dudarev on 09.12.2021.
//

import SwiftUI

public struct Screen: Identifiable, Equatable {
    
    public let id: String = UUID().uuidString
    public let nextScreen: AnyView
    
    public static func ==(lhs: Screen, rhs: Screen) -> Bool {
        lhs.id == rhs.id
    }
}
