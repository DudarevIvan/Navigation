//
//  File.swift
//  
//
//  Created by Ivan Dudarev on 11.12.2021.
//

import SwiftUI

extension View {
    func toAny() -> AnyView {
        AnyView(self)
    }
}
