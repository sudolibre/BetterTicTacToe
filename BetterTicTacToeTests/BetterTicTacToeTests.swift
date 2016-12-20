//
//  BetterTicTacToeTests.swift
//  BetterTicTacToeTests
//
//  Created by Jonathon Day on 12/15/16.
//  Copyright © 2016 dayj. All rights reserved.
//

import XCTest
@testable import BetterTicTacToe

class BetterTicTacToeTests: XCTestCase {
    let testPlayers = [Player(name: "TestX"), Player(name: "TextO")]
    
    func testInitFromSaved() {
        let savedState: [Board.Place: Board.Marker] = [
            Board.Place(row: .top, column: .left): .x,
            Board.Place(row: .top, column: .middle) : .o,
            Board.Place(row: .top, column: .right) : .x,
            Board.Place(row: .middle, column: .left) : .o,
            Board.Place(row: .middle, column: .middle) : .empty,
            Board.Place(row: .middle, column: .right) : .empty,
            Board.Place(row: .bottom, column: .left) : .x,
            Board.Place(row: .bottom, column: .middle) : .empty,
            Board.Place(row: .bottom, column: .right) : .o,
            ]
        let resultingBoard = Board(savedState: savedState, players: testPlayers)
        XCTAssertTrue(savedState == resultingBoard.currentState)
    }
    
    func testTextDescriptionOfBoard() {
        let savedState: [Board.Place: Board.Marker] = [
            Board.Place(row: .top, column: .left): .x,
            Board.Place(row: .top, column: .middle) : .o,
            Board.Place(row: .top, column: .right) : .x,
            Board.Place(row: .middle, column: .left) : .o,
            Board.Place(row: .middle, column: .middle) : .empty,
            Board.Place(row: .middle, column: .right) : .empty,
            Board.Place(row: .bottom, column: .left) : .x,
            Board.Place(row: .bottom, column: .middle) : .empty,
            Board.Place(row: .bottom, column: .right) : .o,
            ]
        let resultingBoard = Board(savedState: savedState, players: testPlayers)
        let expectedBoard = "X | O | X\n----------\nO |   |  \n----------\nX |   | O\n"
        XCTAssertEqual(resultingBoard.description, expectedBoard)
    }
    
    func testPlacingMarker() {
        let savedState: [Board.Place: Board.Marker] = [
            Board.Place(row: .top, column: .left): .x,
            Board.Place(row: .top, column: .middle) : .o,
            Board.Place(row: .top, column: .right) : .x,
            Board.Place(row: .middle, column: .left) : .o,
            Board.Place(row: .middle, column: .middle) : .empty,
            Board.Place(row: .middle, column: .right) : .empty,
            Board.Place(row: .bottom, column: .left) : .x,
            Board.Place(row: .bottom, column: .middle) : .empty,
            Board.Place(row: .bottom, column: .right) : .o,
            ]
        var resultingBoard = Board(savedState: savedState, players: testPlayers)
        resultingBoard.placeMarker(Board.Marker.x, onPlace: Board.Place(row: .middle, column: .middle))
        let resultMarker = resultingBoard.currentState[Board.Place(row: .middle, column: .middle)]
        let expectedMarker = Board.Marker.x
        XCTAssertTrue(resultMarker! == expectedMarker)
    }
    
    func testHasWinningComboColumn() {
        let savedState: [Board.Place: Board.Marker] = [
            Board.Place(row: .top, column: .left): .x,
            Board.Place(row: .top, column: .middle) : .o,
            Board.Place(row: .top, column: .right) : .x,
            Board.Place(row: .middle, column: .left) : .x,
            Board.Place(row: .middle, column: .middle) : .empty,
            Board.Place(row: .middle, column: .right) : .empty,
            Board.Place(row: .bottom, column: .left) : .x,
            Board.Place(row: .bottom, column: .middle) : .empty,
            Board.Place(row: .bottom, column: .right) : .o,
            ]
        let resultingBoard = Board(savedState: savedState, players: testPlayers)
        let didXWin = resultingBoard.hasWinningCombinations(marker: Board.Marker.x)
        let didOWin = resultingBoard.hasWinningCombinations(marker: Board.Marker.o)
        XCTAssertTrue(didXWin)
        XCTAssertTrue(!didOWin)
    }
    
    func testHasWinningComboRow() {
        let savedState: [Board.Place: Board.Marker] = [
            Board.Place(row: .top, column: .left): .x,
            Board.Place(row: .top, column: .middle) : .o,
            Board.Place(row: .top, column: .right) : .x,
            Board.Place(row: .middle, column: .left) : .o,
            Board.Place(row: .middle, column: .middle) : .o,
            Board.Place(row: .middle, column: .right) : .o,
            Board.Place(row: .bottom, column: .left) : .x,
            Board.Place(row: .bottom, column: .middle) : .empty,
            Board.Place(row: .bottom, column: .right) : .o,
            ]
        let resultingBoard = Board(savedState: savedState, players: testPlayers)
        let didXWin = resultingBoard.hasWinningCombinations(marker: Board.Marker.x)
        let didOWin = resultingBoard.hasWinningCombinations(marker: Board.Marker.o)
        XCTAssertTrue(!didXWin)
        XCTAssertTrue(didOWin)
    }
    
    func testHasWinningComboDiagonal() {
        let savedState: [Board.Place: Board.Marker] = [
            Board.Place(row: .top, column: .left): .x,
            Board.Place(row: .top, column: .middle) : .o,
            Board.Place(row: .top, column: .right) : .x,
            Board.Place(row: .middle, column: .left) : .x,
            Board.Place(row: .middle, column: .middle) : .x,
            Board.Place(row: .middle, column: .right) : .empty,
            Board.Place(row: .bottom, column: .left) : .x,
            Board.Place(row: .bottom, column: .middle) : .empty,
            Board.Place(row: .bottom, column: .right) : .x,
            ]
        let resultingBoard = Board(savedState: savedState, players: testPlayers)
        let didXWin = resultingBoard.hasWinningCombinations(marker: Board.Marker.x)
        let didOWin = resultingBoard.hasWinningCombinations(marker: Board.Marker.o)
        XCTAssertTrue(didXWin)
        XCTAssertTrue(!didOWin)
    }
    
    func testAvailablePlaces() {
        let savedState: [Board.Place: Board.Marker] = [
            Board.Place(row: .top, column: .left): .x,
            Board.Place(row: .top, column: .middle) : .o,
            Board.Place(row: .top, column: .right) : .x,
            Board.Place(row: .middle, column: .left) : .o,
            Board.Place(row: .middle, column: .middle) : .empty,
            Board.Place(row: .middle, column: .right) : .empty,
            Board.Place(row: .bottom, column: .left) : .x,
            Board.Place(row: .bottom, column: .middle) : .empty,
            Board.Place(row: .bottom, column: .right) : .o,
            ]
        let resultingBoard = Board(savedState: savedState, players: testPlayers)
        
        let result = resultingBoard.availablePlaces
        let expected = [Board.Place(row: .middle, column: .middle), Board.Place(row: .middle, column: .right), Board.Place(row: .bottom, column: .middle)]
        XCTAssertTrue(result == expected)
    }
    
}
