//
//  Fruits.swift
//  Meu App
//
//  Created by Narely Lima on 04/04/23.
//

import Foundation

struct Fruits: Identifiable, Hashable, Equatable {
    var id = UUID().uuidString
    var value: String
    var padding: CGFloat = 10
    var textSize: CGFloat = .zero
    var fontSize: CGFloat = 10
    var isShowing: Bool = false
}

var fruitsFirst: [Fruits] = [
    Fruits(value: "cupuacu2", isShowing: true),
    Fruits(value: "guarana2"),
    Fruits(value: "pequi2", isShowing: true),
    Fruits(value: "mangaba2", isShowing: true),
    Fruits(value: "pequi2"),
    Fruits(value: "mangaba2", isShowing: true),
    Fruits(value: "guarana2", isShowing: true),
    Fruits(value: "cupuacu2"),
    Fruits(value: "guarana2", isShowing: true),
    Fruits(value: "cupuacu2", isShowing: true),
    Fruits(value: "mangaba2", isShowing: true),
    Fruits(value: "pequi2"),
    Fruits(value: "mangaba2", isShowing: true),
    Fruits(value: "pequi2", isShowing: true),
    Fruits(value: "cupuacu2"),
    Fruits(value: "guarana2", isShowing: true),
]
