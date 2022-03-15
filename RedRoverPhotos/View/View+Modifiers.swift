//
//  View+Modifiers.swift
//  RedRoverPhotos
//
//  Created by Don on 3/14/22.
//

import SwiftUI

struct HiddenNavigationBar: ViewModifier {
    func body(content: Content) -> some View {
        content
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

extension View {
    func hiddenNavigationBarStyle() -> some View {
        modifier( HiddenNavigationBar() )
    }
}

extension HorizontalAlignment {
    struct LeadingAlignmentInternal: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.leading]
        }
    }

    static let leadingAlignmentInternal = HorizontalAlignment(LeadingAlignmentInternal.self)
}
