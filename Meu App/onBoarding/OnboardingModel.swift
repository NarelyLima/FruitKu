//
//  File.swift
//  
//
//  Created by Narely Lima on 07/04/23.
//

import SwiftUI

struct OnBoardingModel: Hashable, Equatable {
    var image: String
    var imageGif: String
    var title: String
    var description: String
}

var onBoardingModel: [OnBoardingModel] = [
    OnBoardingModel(image: "Sudoku", imageGif: "", title: "DID YOU KNOW?", description: "Sudoku develops some skills like concentration, memory and logic. In this way, in addition to being a hobby, it is used to improve your quality of life!"),
    OnBoardingModel(image: "Sudoku", imageGif: "", title: "", description: "Here, you will have contact with an adaptation of sudoku, as the numbers will be exchanged for fruits typical of Brazil."),
    OnBoardingModel(image: "Sudoku", imageGif: "", title: "", description: "With each completed sudoku, a part of the tent will be made available for you to click on and learn a little more about the fruits of that level."),
    OnBoardingModel(image: "", imageGif: "colunaGif", title: "Sudoku has 3 rules:", description: "1. The representation of elements cannot be repeated in any column."),
    OnBoardingModel(image: "", imageGif: "linhaGif", title: "Sudoku has 3 rules:", description: "2. The representation of elements cannot be repeated in any line."),
    OnBoardingModel(image: "", imageGif: "quadradoGif", title: "Sudoku has 3 rules:", description: "3. The representation of elements cannot be repeated in any 2x2 grid."),
    OnBoardingModel(image: "", imageGif: "tutorialGif", title: "", description: "If you still have questions about the rules, just press ? that you will have access to the tutorial!")
]
