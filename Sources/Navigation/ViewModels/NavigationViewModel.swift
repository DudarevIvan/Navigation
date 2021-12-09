//
//  File.swift
//  
//
//  Created by Ivan Dudarev on 09.12.2021.
//

import SwiftUI

public final class NavigationViewModel: ObservableObject {
    
    @Published var currentScreen: Screen?
    
    private var stack: Stack = .init() {
        didSet {
            self.currentScreen = stack.topScreen()
        }
    }
    
    public var navigationType: NavigationType = .push
    
    private let animation: Animation
    
    public init(with animation: Animation) {
        self.animation = animation
    }
    
    public func push<S: View>(_ screenView: S) {
        navigationType = .push
        withAnimation(animation) {
            let screen: Screen = .init(nextScreen: AnyView(screenView))
            stack.push(screen)
        }
    }
    
    public func pop() {
        navigationType = .pop
        withAnimation(animation) {
            stack.pop()
        }
    }
    
    public func popToRoot() {
        navigationType = .popToRoot
        withAnimation(animation) {
            stack.popToRoot()
        }
    }
}
