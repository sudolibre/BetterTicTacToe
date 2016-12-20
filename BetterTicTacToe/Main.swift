//
//  Main.swift
//  BetterTicTacToe
//
//  Created by Jonathon Day on 12/15/16.
//  Copyright © 2016 dayj. All rights reserved.
//

/*





Allow users to play again with or without entering new names

The program should keep track of player's wins and losses

Bonus

save matchup history (TJ vs Dom)
Allow users to view game history (wins/losses)
Save moves for the last game
Save moves for all games

How many games the players would like to play in this match in 'best of' form. (best of 3, best of 7, etc)

Allow users to view match history (wins/losses)
*/

import Foundation

func mainLoop() {
    print("Hello and welcome to Tic-Tac-Toe.")
    var usersPlayingGames = true
    var existingPlayers = [Player]()
    
    while usersPlayingGames == true {
        let playedGame: Board
        if existingPlayers.count < 2 {
            let newGame = setupGame()
            playedGame = playGame(game: newGame)
        } else {
            print("\(existingPlayers[0].name) : \(existingPlayers[0].wins.count) \n\(existingPlayers[1].name) : \(existingPlayers[1].wins.count)")
            let nextGame = Board(playerX: existingPlayers[0], playerO: existingPlayers[1])
            playedGame = playGame(game: nextGame)
        }
        let shouldContinue = answerToQuestion("Would you like to play a rematch?", withPossibleAnswers: ["Yes", "No"])
        if shouldContinue == 1 {
            usersPlayingGames = false
        } else {
            existingPlayers.append(playedGame.playerX)
            existingPlayers.append(playedGame.playerO)
        }
    }
}


func setupGame() -> Board {
    let playerXName = answerQuestion("What is the name of the first Player? The first player will place X's on the board")
    let playerX = Player(name: playerXName)
    let playerOName = answerQuestion("What is the name of the second Player? The second player will place O's on the board")
    let playerO = Player(name: playerOName)
    let game = Board(playerX: playerX, playerO: playerO)
    return game
}

func playGame(game: Board) -> Board {
    var playedGame = game
    while playedGame.gameWon == false {
        print(playedGame)
        let indexForMoveOfPlayerX = answerToQuestion("\(playedGame.playerX.name) please choose the next place you would like mark", withPossibleAnswers: playedGame.availablePlaces.map { $0.description })
        playedGame.placeMarker(.x, onPlace: playedGame.availablePlaces[indexForMoveOfPlayerX])
        if playedGame.gameWon || playedGame.availablePlaces.count == 0 {
            break
        }
        print(playedGame)
        let indexFormoveOfPlayerO = answerToQuestion("\(playedGame.playerO.name) please choose the next place you would like mark", withPossibleAnswers: playedGame.availablePlaces.map { $0.description })
        playedGame.placeMarker(.o, onPlace: playedGame.availablePlaces[indexFormoveOfPlayerO])
        if playedGame.gameWon || playedGame.availablePlaces.count == 0 {
            break
        }
    }
    if playedGame.hasWinningCombinations(marker: .x) {
        print("\(playedGame.playerX.name) has won!")
        playedGame.playerX.wins.append(playedGame)
        playedGame.playerO.losses.append(playedGame)
    } else if playedGame.hasWinningCombinations(marker: .o) {
        print("\(playedGame.playerX.name) has won!")
        playedGame.playerX.losses.append(playedGame)
        playedGame.playerO.wins.append(playedGame)
    } else {
        print("The game was a draw!")
        playedGame.playerX.draw.append(playedGame)
        playedGame.playerO.draw.append(playedGame)
    }
    return playedGame
}


func answerToQuestion(_ question: String, withPossibleAnswers possibleAnswers: [String]) -> Int {
    print(question)
    var intAnswer: Int?
    let selection = possibleAnswers.enumerated()
    for i in selection {
        print("\(i.offset) - \(i.element)")
    }
    
    while intAnswer == nil {
    let answer = readLine(strippingNewline: true)!
        if let answer = Int(answer) {
            if answer < possibleAnswers.count {
              intAnswer = answer
            } else {
                print("invalid selection. Please select a number between 0 and \(possibleAnswers.count - 1)")
            }
        } else {
            print("invalid selection. Please select a number between 0 and \(possibleAnswers.count - 1)")
        }
    }
    return intAnswer!
}

func answerQuestion(_ question: String) -> String {
    print(question)
    let answer = readLine(strippingNewline: true)!
    return answer
}



