//
//  ContentView.swift
//  Shared
//
//  Created by Levent yadırga on 31.01.2022.
//

import SwiftUI



struct ContentView: View {
    
    private var columnGrid = [GridItem(.flexible(minimum: 70, maximum: .infinity), spacing: 0), GridItem(.flexible(minimum: 70, maximum: .infinity), spacing: 0), GridItem(.flexible(minimum: 70, maximum: .infinity), spacing: 0)]
    private var columnGrid2 = [GridItem(.flexible(minimum: 70, maximum: .infinity)), GridItem(.flexible(minimum: 70, maximum: .infinity))]
    
    
    
    @ObservedObject var viewModel: ViewModel = ViewModel()
    @State private var dragOffset: [CGSize] = Array(repeating: .zero, count: 9)
    
    @State private var gameAreaHeight: CGFloat = 0
    
    private func resetPosition(_ id: Int){
        withAnimation() {
            dragOffset[id] = .zero
        }
    }
    
    private func eslesmeOldu(_ position: Int, _ id: Int){
        
        withAnimation {
            viewModel.eslesmeOldu(position,id)
        }
        
        if viewModel.gameOver {
            playSound(sound: "winner", type: "mp3")
        }else{
            playSound(sound: "correct_answer", type: "mp3")
        }
    }
    
    private func checkPosition(location: CGPoint, id: Int){
        
        let x = location.x
        let y = location.y
        
        print("y: \(y) height: \(gameAreaHeight) screenWidth:\(screenWidth)")
        
        
        
        if x < screenWidth * 0.33 && y < gameAreaHeight * 0.33{
            print("Birinci konum")
            if viewModel.eslesmeKontrol(position: 0, id: id){
                eslesmeOldu(0,id)
            }else{resetPosition(id)}
            
        }
        else if x > screenWidth * 0.33 && x < screenWidth * 0.66 && y < gameAreaHeight * 0.33{
            print("İkinci konum")
            if viewModel.eslesmeKontrol(position: 1, id: id){
                eslesmeOldu(1,id)
            }else{resetPosition(id)}
        }
        
        
        
        else if x > screenWidth * 0.66 && y < gameAreaHeight * 0.33{
            print("Üçüncü konum")
            if viewModel.eslesmeKontrol(position: 2, id: id){
                eslesmeOldu(2,id)
            }else{resetPosition(id)}
        }
        
        
        
        else if x < screenWidth * 0.33 && y < gameAreaHeight * 0.66 && y > gameAreaHeight * 0.33 {
            print("Dördüncü konum")
            if viewModel.eslesmeKontrol(position: 3, id: id){
                eslesmeOldu(3,id)
            }else{resetPosition(id)}
        }
        
        
        
        else if x > screenWidth * 0.33 && x < screenWidth * 0.66 && y < gameAreaHeight * 0.66 && y > gameAreaHeight * 0.33 {
            print("Beşinci konum")
            if viewModel.eslesmeKontrol(position: 4, id: id){
                eslesmeOldu(4,id)
            }else{resetPosition(id)}
        }
        
        
        
        if x > screenWidth * 0.66 && y < gameAreaHeight * 0.66 && y > gameAreaHeight * 0.33 {
            print("Altıncı konum")
            if viewModel.eslesmeKontrol(position: 5, id: id){
                eslesmeOldu(5,id)
            }else{resetPosition(id)}
        }
        
        
        
        else if x < screenWidth * 0.33 && y < gameAreaHeight && y > gameAreaHeight * 0.66 {
            print("Yedinci konum")
            if viewModel.eslesmeKontrol(position: 6, id: id){
                eslesmeOldu(6,id)
            }else{resetPosition(id)}
        }
        
        
        
        else if x > screenWidth * 0.33 && x < screenWidth * 0.66 && y < gameAreaHeight && y > gameAreaHeight * 0.66 {
            print("Sekizinci konum")
            if viewModel.eslesmeKontrol(position: 7, id: id){
                eslesmeOldu(7,id)
            }else{resetPosition(id)}
        }
        
        
        
        else if x > screenWidth * 0.66 && y < gameAreaHeight && y > gameAreaHeight * 0.66 {
            print("Dukuzuncu konum")
            if viewModel.eslesmeKontrol(position: 8, id: id){
                eslesmeOldu(8,id)
            }else{resetPosition(id)}
        }else{
            resetPosition(id)
        }
        
        
        
    }
    
    private func fontSize() -> CGFloat {
        
        let fontScaleFactor: CGFloat = 0.75
        
         if isExtraSmall{
            return screenWidth/4 * fontScaleFactor
        }
        
       else if isSmall{
            return screenWidth/3.5 * fontScaleFactor
        }
        
        else if isMacOS {
            return 100
        }
        
        else if isLargestIpad {
            return screenWidth/4.5 * fontScaleFactor
        }
        
        else if isIpad{
            return screenWidth/4 * fontScaleFactor
            
        }
        else{
            return screenWidth/3 * fontScaleFactor
        }
        
        
    }
    
    
    var body: some View {
        
        GeometryReader{ geometry in
        VStack {
            
                LazyVGrid(columns: columnGrid, spacing: 10) {
                        ForEach(viewModel.cards) {card in
                            Text(card.content)
                                .font(Font.system(size: fontSize()))
                                .frame(width: screenWidth * 0.3 ,height: gameAreaHeight * 0.30)
                                .background( Rectangle().stroke().foregroundColor(card.content != "" ? .green : .clear))
                        }
                    }
                
                    .onAppear(){
                        gameAreaHeight = geometry.size.height * 0.50
                }.frame(height: gameAreaHeight, alignment: .center)
            
            
            
            Divider()
            Spacer()
            LazyVGrid(columns: columnGrid2, spacing: 10){
                ForEach(viewModel.cardsSecenek) { card in
                    
                    Text(card.dogruCevap!)
                        .font(Font.system(size: fontSize()))
                        .padding(5)
                        .offset(x: dragOffset[card.id].width, y: dragOffset[card.id].height)
                        .gesture(DragGesture(coordinateSpace: .named("gameArea"))
                                    .onEnded({ value in
                            checkPosition(location: value.location, id: card.id)
                            
                            
                        })
                                    .onChanged({ newValue in
                            
                            withAnimation() {
                                dragOffset[card.id] = newValue.translation
                            }
                            
                        }))
                    
                    
                    
                }
            }.frame(height: gameAreaHeight * 0.5)
            Spacer()
            Button {
                withAnimation {
                    dragOffset = Array(repeating: .zero, count: 9)
                    viewModel.resetGame()
                }
            } label: {
                Text("New Game")
            }
            .buttonStyle(.bordered)
            //.buttonBorderShape(.capsule)
            .tint(.green)
            .padding()
            
        }
    }.coordinateSpace(name: "gameArea")
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .frame(width: 500, height: 900)
            
        }
        
    }
}
