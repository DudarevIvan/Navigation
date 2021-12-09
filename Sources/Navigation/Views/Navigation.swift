//
//  File.swift
//  
//
//  Created by Ivan Dudarev on 09.12.2021.
//

import SwiftUI

public struct Navigation<Content: View>: View {
    
    @ObservedObject var viewModel: NavigationViewModel
    
    private let content: Content
    private let transitions: (push: AnyTransition, pop: AnyTransition)
    
    public init(_ transition: Transition, _ animation: Animation = .easeInOut(duration: 0.33), @ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        self.viewModel = .init(with: animation)
        
        switch transition {
        case .custom(let screenTransition):
            self.transitions = (screenTransition, screenTransition)
        default:
            self.transitions = (.identity, .identity)
        }
    }
    
    public var body: some View {
        let isRootView = (viewModel.currentScreen == nil)
        return ZStack {
            if isRootView {
                content
                    .transition(viewModel.navigationType == .push ? transitions.push : transitions.pop)
                    .environmentObject(viewModel)
            } else {
                viewModel.currentScreen!.nextScreen
                    .transition(viewModel.navigationType == .push ? transitions.push : transitions.pop)
                    .environmentObject(viewModel)
            }
        }
        .ignoresSafeArea(.all, edges: .top)
        .background(Color.white)
    }
}


extension Navigation {
    
    public func push<Content: View>(view: Content) {
        let item = NavigationItemContainer<Content>(content: view)
        self.viewModel.push(item.toAnyView())
    }
    
    public func pop<Content: View>(@ViewBuilder content: @escaping () -> Content) {
        content()
        viewModel.pop()
    }
    
    public func popToRoot() {
        self.viewModel.popToRoot()
    }
}
