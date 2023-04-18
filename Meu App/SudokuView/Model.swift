//
//  Model.swift
//  Meu App
//
//  Created by Narely Lima on 04/04/23.
//

import SwiftUI

public class Colors {
    static var grid: UIColor = UIColor(named: "Grid") ?? .systemBlue
    static var background: Color = Color("backgroundFruits")
    private init() {}
}

class FleaMarketModel: ObservableObject {
    @Published var completed: Bool = false
    static let shared = FleaMarketModel()

}



