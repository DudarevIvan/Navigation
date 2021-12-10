//
//  File.swift
//  
//
//  Created by Ivan Dudarev on 10.12.2021.
//

import SwiftUI


public enum Destination<D: View> {
    case forward(D)
    case back
    case home
}


public struct NLink<Label: View, D: View>: View {
    
    @EnvironmentObject var viewModel: NavigationViewModel
    
    public let destination: Destination<D>
    public let label: () -> Label
    
    public init(destination: Destination<D>, @ViewBuilder label: @escaping () -> Label) {
        self.destination = destination
        self.label = label
    }
    
    
    //@ViewBuilder
    public var body: some View {
        switch destination {
        case .forward(let screen):
            return label()
                .onTapGesture {
                    if viewModel.currentScreen != nil {
                        viewModel.push(screen)
                    }
                }
        case .back:
            label()
                .onTapGesture {
                    viewModel.pop()
                }
        case .home:
            label()
                .onTapGesture {
                    viewModel.popToRoot()
                }
        }
        
    }
}

//public struct NavigationForward<Label: View, Destination: View>: View {
//
//    @EnvironmentObject var viewModel: NavigationViewModel
//
//    public let label: () -> Label
//    public let destination: () -> Destination
//
//    public init(@ViewBuilder label: @escaping () -> Label, destination: @escaping () -> Destination) {
//        self.label = label
//        self.destination = destination
//    }
//
//    public var body: some View {
//        label()
//            .onTapGesture {
//                if viewModel.currentScreen != nil {
//                    viewModel.push(destination())
//                }
//            }
//            .opacity(viewModel.currentScreen != nil ? 1.0 : 0.5)
//    }
//}
//
//
//public struct NavigationBack<Label: View>: View {
//
//    @EnvironmentObject var viewModel: NavigationViewModel
//
//    private let label: () -> Label
//
//    public init(@ViewBuilder label: @escaping () -> Label) {
//        self.label = label
//    }
//
//    public var body: some View {
//        label()
//            .onTapGesture {
//                viewModel.pop()
//            }
//    }
//}
//
//
//public struct NavigationHome<Label: View>: View {
//
//    @EnvironmentObject var viewModel: NavigationViewModel
//
//    private let label: () -> Label
//
//    public init(@ViewBuilder label: @escaping () -> Label) {
//        self.label = label
//    }
//
//    public var body: some View {
//        label()
//            .onTapGesture {
//                viewModel.popToRoot()
//            }
//    }
//}
