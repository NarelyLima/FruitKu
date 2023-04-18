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
            VStack {
                TabView(selection: $index) {
                    ForEach((0..<onBoarding.count), id: \.self) { index in
                        VStack {
                            Image(onBoarding[index].image)
                                .resizable()
                                .frame(width: 250, height: 250)
                                .padding(.bottom, 30)
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
                               .foregroundColor(Color.gray)
                       }
                   }
               }
               .padding(.bottom, 30)
                Button {
                    if self.index < onBoardingModel.count - 1 {
                        self.index += 1
                        if self.index == onBoardingModel.count - 1 {
                            isFinal = true
                        }
                    }
                } label: {
                    Text(index < onBoarding.count - 1 ? "Next" : "")
                        .foregroundColor(.black)
                }
                .buttonStyle(PlainButtonStyle())
                isFinal ? navApp : nil
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    var navApp: some View {
        NavigationLink(destination: FleaMarket().navigationBarBackButtonHidden(), label: {
                HStack { Text("Get Started")
                        .foregroundColor(.black)
                }
        })
    }
}


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
