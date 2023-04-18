//
//  OnboardingView.swift
//  Meu App
//
//  Created by Narely Lima on 04/04/23.
//

import SwiftUI

struct OnboardingView: View {

    @State private var index = 0
    @State var isFinal: Bool = false
    @State var onBoarding: [OnBoardingModel] = onBoardingModel

    var body: some View {
        NavigationView {
            ZStack{
                Colors.background
                VStack {
                    TabView(selection: $index) {
                        ForEach((0..<onBoarding.count), id: \.self) { index in
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
                            }
                            .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    HStack {
                        ForEach(0..<onBoarding.count, id: \.self) { model in
                           if model == index {
                               Circle()
                                   .frame(width: 20, height: 20)
                                   .foregroundColor(Color.black)
                           } else {
                               Circle()
                                   .frame(width: 20, height: 20)
                                   .foregroundColor(.white)
                           }
                       }
                   }
                   .padding(.bottom, 30)
                    Button {
                        if self.index < onBoardingModel.count - 1 {
                            self.index += 1
                            if self.index == onBoardingModel.count - 1 {
                                isFinal.toggle()
                            }
                        }
                    } label: {
                        ZStack{
                            index < onBoarding.count - 1 ?
                            Rectangle()
                                .frame(width: 100, height: 50)
                                .foregroundColor(.black)
                                .cornerRadius(10) :
                            nil
                            Text(index < onBoarding.count - 1 ? "Next" : "")
                                .font(.title)
                                .foregroundColor(Colors.background)
                        }

                    }
                    .buttonStyle(PlainButtonStyle())
                    isFinal ? navApp : nil
                }
                .padding(.bottom, 30)
            }

            .ignoresSafeArea()

        }
        .navigationViewStyle(StackNavigationViewStyle())

    }
    var navApp: some View {
        NavigationLink(destination: FleaMarket().navigationBarBackButtonHidden(), label: {
                ZStack {
                    Rectangle()
                        .frame(width: 200, height: 50)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                    Text("Get Started")
                        .font(.title)
                        .foregroundColor(Colors.background)
                }
        })
    }
}


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
