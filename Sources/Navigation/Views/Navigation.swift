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
    
    public init(_ transition: Transition = .none, _ animation: Animation = .easeInOut(duration: 0.33), @ViewBuilder content: @escaping () -> Content) {
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
    
    public struct NavigationForward<Label: View, Destination: View> {
        
        @EnvironmentObject var viewModel: NavigationViewModel
        
        public let label: () -> Label
        public let destination: Destination
        
        public init(@ViewBuilder label: @escaping () -> Label, destination: Destination) {
            self.label = label
            self.destination = destination
        }
        
        public var body: some View {
            label()
                .onTapGesture {
                    viewModel.push(destination)
                }
        }
    }
    
    
    public struct NavigationBack<Label>: View where Label: View {
        
        @EnvironmentObject var viewModel: NavigationViewModel
        
        private let label: () -> Label
        
        public init(@ViewBuilder label: @escaping () -> Label) {
            self.label = label
        }
        
        public var body: some View {
            label()
                .onTapGesture {
                    viewModel.pop()
                }
        }
    }
    
    
    public struct NavigationHome<Label>: View where Label: View {
        
        @EnvironmentObject var viewModel: NavigationViewModel
        
        private let label: () -> Label
        
        public init(@ViewBuilder label: @escaping () -> Label) {
            self.label = label
        }
        
        public var body: some View {
            label()
                .onTapGesture {
                    viewModel.popToRoot()
                }
        }
    }
}
