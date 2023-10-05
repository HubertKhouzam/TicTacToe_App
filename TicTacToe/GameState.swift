//
//  GameState.swift
//  TicTacToe
//
import Foundation

class GameState: ObservableObject
{
    @Published var board = [[Cell]]()
    @Published var turn = Tile.Cross
    @Published var noughtScore = 0
    @Published var crossScore = 0
    @Published var showAlert = false
    @Published var alertMessage = "Draw"

    init()
    {
        resetBoard()
    }
    //Game with two players
    func placeTile(_ row: Int, _ column: Int)
    {
        if board[row][column].tile != Tile.Empty
        {
            return
        }
        board[row][column].tile = turn == Tile.Cross ? Tile.Cross : Tile.Nought
        
        
        if checkForVictory()
        {
            if turn == Tile.Cross
            {
                crossScore += 1
            }
            else
            {
                noughtScore += 1
            }
            let winner = turn == Tile.Cross ? "Crosses" : "Noughts"
            alertMessage = winner + " Win!"
            showAlert = true
        }
        else
        {
            if checkForDraw()
            {
                alertMessage = "Draw"
                showAlert = true
                resetBoard()
            }
            turn = turn == Tile.Cross ? Tile.Nought : Tile.Cross
        }
    }
    //Game against AI
    func placeTile_AI(_ row: Int, _ column: Int)
    {
       
        playerTurn(row, column)
    
        board[row][column].tile = Tile.Cross
        
        
        if checkForVictory()
        {
            if turn == Tile.Cross
            {
                crossScore += 1
            }
            else
            {
                noughtScore += 1
            }
            
            alertMessage = (turn == Tile.Cross ? "Player" : "AI") + " Win!"
            showAlert = true
        }
        else
        {
            if checkForDraw()
            {
                alertMessage = "Draw"
                showAlert = true
                resetBoard()
            }
        }
        turn = turn == Tile.Cross ? Tile.Nought : Tile.Cross
        botmove()
        
        if checkForVictory()
        {
            if turn == Tile.Cross
            {
                crossScore += 1
            }
            else
            {
                noughtScore += 1
            }
            
            alertMessage = (turn == Tile.Cross ? "Player" : "AI") + " Win!"
            showAlert = true
        }
        else
        {
            if checkForDraw()
            {
                alertMessage = "Draw"
                showAlert = true
                resetBoard()
            }
        }
        turn = turn == Tile.Cross ? Tile.Nought : Tile.Cross
    }
    
    func checkForDraw() -> Bool
    {
        for row in board
        {
            for cell in row
            {
                if cell.tile == Tile.Empty
                {
                    return false
                }
            }
        }
        
        return true
    }
    
    func playerTurn(_ row: Int, _ column: Int)
    {
        if board[row][column].tile != Tile.Empty
        {
            return
        }
        board[row][column].tile =  Tile.Cross
    }
    
    func checkForVictory() -> Bool
    {
        //Si aligne verticalement
        if isTurnTile(0, 0) && isTurnTile(1, 0) && isTurnTile(2, 0)
        {
            return true
        }
        if isTurnTile(0, 1) && isTurnTile(1, 1) && isTurnTile(2, 1)
        {
            return true
        }
        if isTurnTile(0, 2) && isTurnTile(1, 2) && isTurnTile(2, 2)
        {
            return true
        }
        
        //Si aligne horizontalement
        if isTurnTile(0, 0) && isTurnTile(0, 1) && isTurnTile(0, 2)
        {
            return true
        }
        if isTurnTile(1, 0) && isTurnTile(1, 1) && isTurnTile(1, 2)
        {
            return true
        }
        if isTurnTile(2, 0) && isTurnTile(2, 1) && isTurnTile(2, 2)
        {
            return true
        }
        // Si aligne diagonalement
        if isTurnTile(0, 0) && isTurnTile(1, 1) && isTurnTile(2, 2)
        {
            return true
        }
        if isTurnTile(0, 2) && isTurnTile(1, 1) && isTurnTile(2,0)
        {
            return true
        }
        
        return false
    }
    
    func isTurnTile(_ row: Int, _ column: Int) -> Bool
    {
        return board[row][column].tile == turn
    }
    
    func turnText() -> String
    {
        return turn == Tile.Cross ? "Turn: X" : "Turn: O"
    }
    
    func botmove()
    {
        var possibleMoves: [[Int]] = [[]]
        for row in 0...2
        {
            for column in 0...2
            {
                if board[row][column].tile == Tile.Empty
                {
                    possibleMoves.append([row,column])
                }
            }
        }
        
        possibleMoves.removeFirst()
        
        print(possibleMoves)
        
        
        if possibleMoves.count != 0
        {
            let moveToDo  = possibleMoves.randomElement()!
            board[moveToDo[0]][moveToDo[1]].tile = Tile.Nought
        }

    }
    
    func resetBoard()
    {
        var newBoard = [[Cell]]()
        
        for _ in 0...2
        {
            var row = [Cell]()
            for _ in 0...2
            {
                row.append(Cell(tile: Tile.Empty))
            }
            newBoard.append(row)
        }
        board = newBoard
    }
}
