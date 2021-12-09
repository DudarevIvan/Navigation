//
//  File.swift
//  
//
//  Created by Ivan Dudarev on 09.12.2021.
//

import Foundation

public struct Stack {
    
    private var screens: Array<Screen> = .init()
    
    public mutating func push(_ screen: Screen) {
        screens.append(screen)
    }
    
    public mutating func pop() {
        _ = screens.popLast()
    }
    
    public mutating func popToRoot() {
        screens.removeAll()
    }
    
    public func topScreen() -> Screen? {
        screens.last
    }
    
}
