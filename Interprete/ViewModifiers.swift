//
//  ViewModifiers.swift
//  Interprete
//
//  Created by Максим Митрофанов on 21.05.2022.
//

import SwiftUI

struct InterpreteButtonStyle: ButtonStyle {
    let lightShadowColor = Color.white.opacity(0.3)
    let darkShadowColor = Color.gray.opacity(0.3)
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(8)
            .background(
                Capsule()
                    .foregroundColor(.white)
            )
        
    }
}

struct DoubleRoundedButtonStyle: ButtonStyle {
    var color: Color = Color.gray.opacity(0.2)
    var cornerRadius: CGFloat = 12
    var lineWidth: CGFloat = 3
    var paddingScale: CGFloat = 8
        
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .doubleRoundedBackground(
                color: color,
                cornerRadius: cornerRadius,
                lineWidth: lineWidth,
                paddingScale: paddingScale
            )
            .opacity(configuration.isPressed ? 0.3 : 1)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}

extension View {
    func roundedBackground(color: Color = .gray, cornerRadius: CGFloat = 16, paddingScale: CGFloat = 10) -> some View {
        self
            .padding(paddingScale)
            .background(color)
            .cornerRadius(cornerRadius)
    }
    
    func doubleRoundedBackground(color: Color, cornerRadius: CGFloat, lineWidth: CGFloat = 1, paddingScale: CGFloat = 10) -> some View {
        self
            .padding(paddingScale)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius - 3)
                    .foregroundColor(color)
            )
            .padding(3)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: lineWidth)
                    .foregroundColor(color)
            )
    }
}
