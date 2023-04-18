//
//  File.swift
//  
//
//  Created by Narely Lima on 07/04/23.
//

import SwiftUI

struct OnBoardingModel: Hashable, Equatable {
    var image: String
    var title: String
    var description: String
}

var onBoardingModel: [OnBoardingModel] = [
    OnBoardingModel(image: "Sudoku", title: "VOCÊ SABIA?", description: "O sudoku desenvolve algumas habilidades como concentração, memória e lógica. Desse modo, além de um passatempo, ele é usado para melhorar sua qualidade de vida!"),
    OnBoardingModel(image: "Sudoku", title: "", description: "Aqui, você terá contato com uma adaptação do sudoku, pois os números serão trocados por frutas típicas do Brasil."),
    OnBoardingModel(image: "Sudoku", title: "", description: "A cada sudoku finalizado, uma parte da tenda será disponibilizada para você clicar e saber um pouco mais sobre as frutas daquele nível"),
    OnBoardingModel(image: "Sudoku", title: "O Sudoku possui 3 regras:", description: "1. A representação dos elementos não pode se repetir em nenhuma coluna."),
    OnBoardingModel(image: "Sudoku", title: "O Sudoku possui 3 regras:", description: "2. A representação dos elementos não pode se repetir em nenhuma linha."),
    OnBoardingModel(image: "Sudoku", title: "O Sudoku possui 3 regras:", description: "3. A representação dos elementos não pode se repetir em nenhuma grade 2x2"),
    OnBoardingModel(image: "Sudoku", title: "Para mover as frutas:", description: "Pressione e arraste o elemento para o espaço vazio que ela poderia ficar"),
    OnBoardingModel(image: "Sudoku", title: "", description: "Caso você ainda tenha dúvidas sobre as regras, é só apertar no ? que você terá acesso ao tutorial!"),

]
