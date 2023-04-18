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
        popupView(nameImg: "pequi2", text1: "O pequi é um fruto típica do cerrado brasileiro", text2: "Tem o tamanho de uma maça, possui casca verde, polpa amarelo claro e um endocarpo espinhoso que protege as sementes. Possui o sabor adocicado")
    }
    var guaranaView: some View {
        popupView(nameImg: "guarana2", text1: "O guaraná é uma fruta típica da Amazônia, região norte do Brasil", text2: "É pequena, com casca vermelha, polpa branca e parece um olho. Tem o sabor adstringente e amargo")
    }
    var cupuacuView: some View {
        popupView(nameImg: "cupuacu2", text1: "O cupuaçu é uma fruta típica da Amazônia, região norte do Brasil.", text2: "Possui tamanho médio de 25 cm e peso de 1 kg, com casca dura e lisa de coloração castanho-escura que reveste uma polpa branca e ácida. Tem o sabor azedo e agridoce")
    }
    var mangabaView: some View {
        popupView(nameImg: "mangabaa2", text1: "A mangaba é uma fruta típica da região nordeste brasileira", text2: "É pequena e redonda, possuindo ate 6 cm, com casca amarela e polpa branca. Possui o sabor doce.")
    }
    func toolbarView(name: String, @Binding showing: Bool) -> some ToolbarContent {
        Group {
            ToolbarItemGroup(placement: .principal) {
                Text(name)
                    .font(.title)
            }
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
    func popupView(nameImg: String, text1: String, text2: String) -> some View {
        ZStack {
            Rectangle()
                .cornerRadius(20)
                .foregroundColor(.cyan)
            VStack(spacing: 20){
                Image(nameImg)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                Text("Origem")
                    .font(.largeTitle)
                Text(text2)
                    .font(.title)
                Text("Características:")
                    .font(.largeTitle)
                Text(text2)
                    .font(.title)
                    .padding(.leading,10)
                    .padding(.trailing, 10)
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
}

struct FleaMarket_Previews: PreviewProvider {
    static var previews: some View {
        FleaMarket()
    }
}
