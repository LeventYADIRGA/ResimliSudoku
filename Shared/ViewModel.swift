//
//  ViewModel.swift
//  ResimliSudoku
//
//  Created by Levent yadırga on 31.01.2022.
//

import Foundation

final class ViewModel: ObservableObject{
    
    @Published private var model: SudokuGame = ViewModel.createSudokuGame()
    
   
    
    private static func createSudokuGame() -> SudokuGame{
           return SudokuGame()
       }
    
    
      //MARK: -Access to the model
      var cards : Array<SudokuGame.Card>{
          return model.cards
      }
    
    var cardsSecenek : Array<SudokuGame.Card>{
        return model.cardsSecenek
    }
    var gameOver : Bool{
        return model.gameOver
    }
    
    func eslesmeOldu(_ position: Int,_ id: Int){
        model.eslesmeOldu(position,id)
    }
    
    func eslesmeKontrol(position: Int, id: Int)-> Bool{
        return model.eslesmeKontrol(position: position, id: id)
    }
   
    
    func resetGame() {
           model = ViewModel.createSudokuGame()
       }
}
