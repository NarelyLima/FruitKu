import SwiftUI

struct FleaMarket: View {
    
    @StateObject var fleaModel = FleaMarketModel()
    @State var showingPequiDetails: Bool = false
    @State var showingGuaranaDetails: Bool = false
    @State var showingCupuacuDetails: Bool = false
    @State var showingMangabaDetails: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack{
                background
                fruitsFlea
                    .padding(.top, 500)
                fruitsPlate
                    .padding(.top, 675)
                fleaFirst
                    .padding(.top, 300)
            }
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .popupNavigationView(horizontalPadding: 200, show: $showingPequiDetails) {
            pequiView
                .toolbar {
                    toolbarView(name: "Pequi", $showing: $showingPequiDetails)
                }
        }
        .popupNavigationView(show: $showingGuaranaDetails) {
            guaranaView
                .toolbar {
                    toolbarView(name: "Guarana", $showing: $showingGuaranaDetails)
                }
        }
        .popupNavigationView(show: $showingCupuacuDetails) {
            cupuacuView
                .toolbar {
                    toolbarView(name: "Cupuacu", $showing: $showingCupuacuDetails)
                }
        }
        .popupNavigationView(show: $showingMangabaDetails) {
            mangabaView
                .toolbar {
                    toolbarView(name: "Mangaba", $showing: $showingMangabaDetails)
                }
        }
    }
    var background: some View {
        ZStack {
            Image("Fundo2")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .leading)
            Image("Flea")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width/1.1, height: UIScreen.main.bounds.height/1.1)
        }
    }
    var fruitsPlate: some View {
        HStack(spacing: 50) {
            HStack(spacing: 60){
                fruitsPlate(imgName: "pequiPlate")
                fruitsPlate(imgName: "mangabaPlate")
                    .padding(.top, 8)
            }
            fruitsPlate(imgName: "cupuacuPlate")
                .padding(.top, 8)
            fruitsPlate(imgName: "guaranaPlate")
                .padding(.top, 8)
        }
    }
    var fruitsFlea: some View {
        HStack(spacing: 40){
            buttonPequi
            buttonMangaba
            buttonCupuacu
            buttonGuarana
        }
    }
    
    @ViewBuilder
    var fleaFirst: some View {
        if UserDefaults.standard.bool(forKey: "CompletedOne") {
        } else {
            navigationFirst
        }
    }
    var navigationFirst: some View {
        NavigationLink(destination: SudokuFirstView().environmentObject(fleaModel), label: {
            HStack {
                Image("play")
                    .resizable()
                    .scaledToFit()
                    .padding(.top, 300)
                    .frame(height: 1050)
            }
        }
        )
    }
    var buttonPequi: some View {
        buttonfruits($showing: $showingPequiDetails, imgName: "pequiFlea")
    }
    var buttonMangaba: some View {
        buttonfruits($showing: $showingMangabaDetails, imgName: "mangabaFlea")
    }
    var buttonCupuacu: some View {
        buttonfruits($showing: $showingCupuacuDetails, imgName: "cupuacuFlea", size: 130)
    }
    var buttonGuarana: some View {
        buttonfruits($showing: $showingGuaranaDetails, imgName: "guarana2")
    }
    var pequiView: some View {
        popupView(name: "Pequi", nameImg: "pequi2", text1: "The pequi is a typical fruit of the Brazilian cerrado", text2: "It is the size of an apple, has a green skin, light yellow flesh and a thorny endocarp that protects the seeds. It has a sweet taste.")
    }
    var guaranaView: some View {
        popupView(name: "Guaraná", nameImg: "guarana2", text1: "Guarana is a typical fruit from the Amazon Forest, northern region of Brazil.", text2: "It is small, with a red skin, white flesh and looks like an eye. It has astringent and bitter taste.")
    }
    var cupuacuView: some View {
        popupView(name: "Cupuaçu", nameImg: "cupuacu2", text1: "Cupuaçu is a typical fruit from the Amazon Forest, in the northern region of Brazil.", text2: "It has an average size of 25 cm and a weight of 1 kg, with a hard, smooth, dark brown skin that covers a white and acid pulp. It has a sour and bittersweet taste.")
    }
    var mangabaView: some View {
        popupView(name: "Mangaba", nameImg: "mangaba2", text1: "Mangaba is a typical fruit from the northeast region of Brazil.", text2: "It is small and round, measuring up to 6 cm, with yellow skin and white pulp. It has a sweet taste.")
    }
    func toolbarView(name: String, @Binding showing: Bool) -> some ToolbarContent {
        Group {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button {
                    withAnimation {
                        showing = false
                    }
                } label: {
                    Image(systemName: "xmark.circle")
                }
            }
        }
    }
    func popupView(name: String,nameImg: String, text1: String, text2: String) -> some View {
        ZStack {
            Rectangle()
                .cornerRadius(20)
                .foregroundColor(Colors.background)
            VStack(alignment: .center, spacing: 20){
                Text(name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Image(nameImg)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                Text("Origin")
                    .font(.largeTitle)
                Text(text1)
                    .font(.title)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)

                Text("Characteristics:")
                    .font(.largeTitle)
                Text(text2)
                    .font(.title)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
            }
        }
        .padding()
    }
    func buttonfruits(@Binding showing: Bool, imgName: String, size: CGFloat = 150) -> some View {
        Button {
            withAnimation {
                showing = true
            }
        } label: {
            Image(imgName)
                .resizable()
                .scaledToFill()
                .frame(width: size, height: size)
        }
    }
    func fruitsPlate(imgName: String, size: CGFloat = 130) -> some View {
        Image(imgName)
            .resizable()
            .scaledToFill()
            .frame(width: size, height: size)
    }
}

struct FleaMarket_Previews: PreviewProvider {
    static var previews: some View {
        FleaMarket()
    }
}
