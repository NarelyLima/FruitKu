//
//  Extensions.swift
//  Meu App
//
//  Created by Narely Lima on 07/04/23.
//

import SwiftUI

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
extension View {
    func popupNavigationView<Content: View>(horizontalPadding: CGFloat = 100,
                                            verticalPadding: CGFloat = 50,
                                            show: Binding<Bool>,
                                            @ViewBuilder content: @escaping() -> Content) -> some View {
        return self
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)

            .overlay {
                if show.wrappedValue {
                    // MARK: Geometry Reader for reading Container Frame

                    GeometryReader { proxy in

                        Color.primary
                            .opacity(0.15)
                            .ignoresSafeArea()
                        let size = proxy.size

                        NavigationView {
                            content()
                        }
                        .navigationViewStyle(StackNavigationViewStyle())
                        .frame(width: size.width - horizontalPadding, height: size.height/1.5 - verticalPadding, alignment: .center)
                        .cornerRadius(15)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                }
            }
    }
}
