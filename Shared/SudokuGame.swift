//
//  SudokuGame.swift
//  ResimliSudoku
//
//  Created by Levent YADIRGA on 31.01.2022.
//

import Foundation

struct SudokuGame {
    
    private(set) var cards : Array<Card>
    private(set) var cardsSecenek : Array<Card>
    private(set) var secenekIndisleri : [Int]
    private(set) var gameOver = false

    
    func eslesmeKontrol(position: Int, id: Int)-> Bool {
        if secenekIndisleri.contains(position) {
//            let card = cardsSecenek.filter { card in
//                card.id == id
//            }
            var emoji = ""
            for card in cardsSecenek {
                if card.id == id {
                    emoji = card.dogruCevap!
                }
            }
            
            if cards[position].dogruCevap! == emoji {
                return true
            }else{
                return false
            }
            
        }else{
            return false
        }
        
    }
    
    
    
    mutating func eslesmeOldu(_ position: Int, _ id: Int){
        

        cardsSecenek.enumerated().map {i, card in
            if card.id == id {
                cards[position].content = card.dogruCevap!
                cards[position].dogruCevap = nil
                cardsSecenek.remove(at: i)
            }
        }
        
        secenekIndisleri.enumerated().map {i, item in
            if item == position {
                secenekIndisleri.remove(at: i)
            }
        }
        
        
      
        
        gameOver = cardsSecenek.count == 0

    }
    
    init() {
        
        cards = Array<Card>()
        cardsSecenek = Array<Card>()
        secenekIndisleri = []
        
        // 4 tane birbirinden farklı random index oluşturuluyor
        let a = Int.random(in: 0...2)
        let b = Int.random(in: 3...5)
        let c = Int.random(in: 6...8)
        var d = Int.random(in: 0...8)
        while(d==a || d==b || d==c){
            d = Int.random(in: 0...8)
        }
       print("a:\(a) b:\(b) c:\(c) d:\(d)")
        
        secenekIndisleri.append(a)
        secenekIndisleri.append(b)
        secenekIndisleri.append(c)
        secenekIndisleri.append(d)
        
        for (index, data) in gameData[Int.random(in: 0..<gameData.count)].enumerated() {
            
            var content = data
            var dogruCevap: String? = data
            
            if (index==a || index==b || index==c || index==d){
                content = ""
                cardsSecenek.append(Card(id: index, content: content, dogruCevap: dogruCevap))
            } else{
                dogruCevap = nil
            }
            cards.append(Card(id: index, content: content, dogruCevap: dogruCevap))
            cardsSecenek.shuffle()
        }
        
    }
    
    struct Card: Identifiable{
        var id: Int
        var content: String
        var dogruCevap: String?
    }
}
