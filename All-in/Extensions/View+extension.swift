//
//  View+extension.swift
//  All-in
//
//  Created by Daniel  Alves Barreto on 20/07/23.
//

import SwiftUI

extension View {
    func roundedCorner(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}
