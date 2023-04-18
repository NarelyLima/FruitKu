//
//  SudokuView.swift
//  Meu App
//
//  Created by Narely Lima on 04/04/23.
//

import SwiftUI
import AVFoundation

struct SudokuFirstView: View {

    @State var fruits_: [Fruits] = fruitsFirst
    @State var berries: [Fruits] = fruitsFirst.filter {!$0.isShowing}
    @State private var index: Int = 0
    @State var showingTutorial: Bool = false
    @State var progress: CGFloat = 0
    @State var onBoarding: [OnBoardingModel] = onBoardingModel
    // MARK: For Drag Part
    @State var rowsDrag: [[Fruits]] = []
    @State var shuffledRowsDrag: [[Fruits]] = []
    // MARK: For Drop Part
    @State var rows: [[Fruits]] = []
    @State var shuffledRows: [[Fruits]] = []
    // Animate
    @State var animateWrongText: Bool = false
    // Progress
    @State var droppedCount: CGFloat = 0
    @State var idle: Bool = false

    @EnvironmentObject var fleaModel: FleaMarketModel

    @Environment(\.dismiss) var dismiss
    @State private var player: AVAudioPlayer?

    var body: some View {
        NavigationView {
                VStack(spacing: 0) {
                    navBar
                    ZStack {
                        gridSudoku
                        DropArea()

                    }
                    .padding(.vertical, 30)
                    DragArea()
                    Spacer()
                }
                .padding()
                .onAppear {
                    if rows.isEmpty {
                        fruits_ = fruits_.shuffled()
                        shuffledRows = generatedGrid()
                        shuffledRowsDrag = generatedGridDrag()
                        fruits_ = fruitsFirst
                        rows = generatedGrid()
                        rowsDrag = generatedGridDrag()
                    }
                }
                .offset(x: animateWrongText ? -30 : 0)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .popupNavigationView(show: $showingTutorial, content: {
            tutorialView
                .toolbar {
                    ToolbarItemGroup(placement: .principal) {
                        Text("Tutorial")
                            .font(.title2)
                    }
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button {
                            withAnimation {
                                showingTutorial = false
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                        }

                    }
                }
        })
        .onAppear {
            withAnimation(Animation.linear(duration: 1.5).speed(4).repeatCount(4)) {
                idle = true
            }
        }

        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                tutorialButton
            }
        }

    }
    var tutorialButton: some View {
        Button {
            withAnimation {
                showingTutorial.toggle()
            }
        } label: {
            Image(systemName: "questionmark.circle")
                .font(.title)
        }
    }
    var gridSudoku: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(Colors.grid))
                .frame(width: 5, height: 670)
            Rectangle()
                .foregroundColor(Color(Colors.grid))
                .frame(width: 670, height: 5)
        }
    }
    var tutorialView: some View {
        VStack {
            TabView(selection: $index) {
                ForEach((3..<onBoarding.count-1), id: \.self) { index in
                    VStack {
                        if onBoarding[index].imageGif != "" {
                            GifImage(onBoarding[index].imageGif)
                                .frame(width: 500, height: 500, alignment: .center)
                                .cornerRadius(50)
                                .padding(.bottom, 20)
                        }
                        if onBoarding[index].image != "" {
                            Image(onBoarding[index].image)
                                .resizable()
                                .frame(width: 250, height: 250)
                                .padding(.bottom, 30)
                        }
                        Text(onBoarding[index].title)
                            .font(.title)
                            .bold()
                        Text(onBoarding[index].description)
                            .multilineTextAlignment(.center)
                            .font(.title)
                            .bold()
                            .padding(.top, 16)
                            .padding(.horizontal, 30)
                            .padding(.bottom, 30)
                        Text(index < onBoardingModel.count - 2 ? "Drag to the side ->" : "")
                    }
                    .tag(index)
                }

            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            HStack {
                ForEach(3..<onBoarding.count-1, id: \.self) { model in
                    if model == index {
                        Circle()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color.black)
                    } else {
                        Circle()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color.gray)
                    }
                }
            }
            .padding(.bottom, 30)
        }
    }
    @ViewBuilder
    func DropArea() -> some View {
        VStack(spacing: 12) {
            ForEach($rows, id:  \.self) { $row in
                HStack(spacing: 10) {
                    ForEach($row) { $item in
                        Image(item.value)
                          .resizable()
                            .scaledToFill()
                            .frame(width: 160, height: 160, alignment: .center)
                            .opacity(item.isShowing ? 1 : 0)
                            .background {
                                RoundedRectangle(cornerRadius: 6, style: .continuous)
                                    .fill(item.isShowing ? Colors.background: .gray.opacity(0.25))
                            }
                            .background {
                                // If item is dropped into correct place
                                RoundedRectangle(cornerRadius: 6, style: .continuous)
                                    .opacity(item.isShowing ? 1 : 0)
                            }
                        // MARK: Adding Drop Operation
                            .dropDestination(for: String.self) { items, _ in
                                if let value = items.first {
                                    if item.value == value {
                                        droppedCount += 1
                                        let progress = (droppedCount/CGFloat(berries.count))
                                        withAnimation {
                                            item.isShowing = true
                                            updateShuffledArray(fruits: item)
                                            self.progress = progress
                                            playAudioView(nameAudio: "drop")
                                        }
                                        if progress == 1 {
                                            fleaModel.completed = true
                                            UserDefaults.standard.set(fleaModel.completed, forKey: "CompletedOne")
                                            dismiss()
                                        }
                                    } else {
                                        animateView()
                                    }
                                }
                                return false
                            }

                    }
                }
            }
        }

    }
    func DragArea() -> some View {
        VStack(spacing: 12) {
            ForEach(shuffledRowsDrag, id:  \.self) { row in
                HStack(spacing: 10) {
                    ForEach(row) { item in
                        Image(item.value)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 145, height: 145, alignment: .center)
                            .background {
                                RoundedRectangle(cornerRadius: 6, style: .continuous)
                                    .stroke(.gray)
                            }
                            .scaleEffect(idle ? 0.9 : 2.1)
                        // MARK: Adding Dra Operation
                            .draggable(item.value)
                            .opacity(item.isShowing ? 0 : 1)
                            .background {
                                RoundedRectangle(cornerRadius: 6, style: .continuous)
                                    .fill(item.isShowing ? .clear : .clear )
                            }
                    }
                }
            }
            .onAppear {
                playAudioView(nameAudio: "drag")
            }

        }
    }
    var navBar: some View {
        VStack(spacing: 30) {
            GeometryReader { proxy in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(.gray.opacity(0.25))
                    Capsule()
                        .fill(Color.green)
                        .frame(width: proxy.size.width * progress)
                }
            }
            .frame(height: 20)
            Text("Solve Sudoku")
                .font(.title2.bold())
        }
    }
    func generatedGrid() ->[[Fruits]] {
        for item in fruits_.enumerated() {
            let textSize = textSize(fruit: item.element)
            fruits_[item.offset].textSize = textSize
        }
        var gridArray: [[Fruits]] = []
        var tempArray: [Fruits] = []

        var currentWidth: CGFloat = 0
        let totalScreenWidth: CGFloat = 350
        for fruit in fruits_ {
            currentWidth += fruit.textSize
            if currentWidth < totalScreenWidth {
                tempArray.append(fruit)
            } else {
                gridArray.append(tempArray)
                tempArray = []
                currentWidth = fruit.textSize
                tempArray.append(fruit)
            }
        }

        if !tempArray.isEmpty {
            gridArray.append(tempArray)
        }
        return gridArray
    }
    func generatedGridDrag() -> [[Fruits]] {
        for item in berries.enumerated() {
            let textSize = textSize(fruit: item.element)
            berries[item.offset].textSize = textSize
        }
        var gridArray: [[Fruits]] = []
        var tempArray: [Fruits] = []

        var currentWidth: CGFloat = 0
        let totalScreenWidth: CGFloat = UIScreen.main.bounds.width - 30
        for fruit in berries {
            currentWidth += fruit.textSize
            if currentWidth < totalScreenWidth {
                tempArray.append(fruit)
            } else {
                gridArray.append(tempArray)
                tempArray = []
                currentWidth = fruit.textSize
                tempArray.append(fruit)
            }
        }

        if !tempArray.isEmpty {
            gridArray.append(tempArray)
        }
        return gridArray
    }
    func textSize(fruit: Fruits) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fruit.fontSize)
        let attributes = [NSAttributedString.Key.font: font]
        let size = (fruit.value as NSString).size(withAttributes: attributes)
        return size.width + (fruit.padding * 2) + 15
    }
    func updateShuffledArray(fruits: Fruits) {
        for index in shuffledRowsDrag.indices {
            for subIndex in shuffledRowsDrag[index].indices {
                if shuffledRowsDrag[index][subIndex].id == fruits.id {
                    shuffledRowsDrag[index][subIndex].isShowing = true
                }
            }
        }
    }
    func animateView() {
        withAnimation(.interactiveSpring(response: 0.1, dampingFraction: 0.1, blendDuration: 0.1)) {
            animateWrongText = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.interactiveSpring(response: 0.1, dampingFraction: 0.1, blendDuration: 0.1)) {
                animateWrongText = false
            }
        }
    }

    func playAudioView(nameAudio: String) {
        let soundURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: nameAudio, ofType: "mp3")!)
        do {
            player = try AVAudioPlayer(contentsOf: soundURL as URL)
            player?.play()
        } catch {
            print("there was some error. The error was \(error)")
        }
    }
}
