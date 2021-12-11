//
//  File.swift
//  
//
//  Created by Ivan Dudarev on 10.12.2021.
//

import SwiftUI

public struct NLink<Label: View>: View {
    
    @EnvironmentObject var viewModel: NavigationViewModel
    
    public let destination: Destination
    public let label: () -> Label
    
    public init(destination: Destination, @ViewBuilder label: @escaping () -> Label) {
        self.destination = destination
        self.label = label
    }
    
    public var body: some View {
        switch destination {
        case .forward(let screen):
            label()
                .onTapGesture {
                    viewModel.push(screen)
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
