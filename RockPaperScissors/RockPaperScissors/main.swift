//
//  RockPaperScissors - main.swift
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

var whoseTurn: Game.Turn = .user

enum Hand: Int {
    case scissors
    case rock
    case paper
    case none
}

enum Game {
    enum Turn {
        case user
        case computer
        
        var printedText: String {
            switch self {
            case .user:
                return "사용자"
            case .computer:
                return "컴퓨터"
            }
        }
    }
    
    enum Finish {
        static let shutDown = "0"
    }

    enum Result {
        case userWin
        case userLose
        case fightAgain
    }
}

enum Message {
    enum Menu {
        static let startGame = "가위(1), 바위(2), 보(3)! <종료 : 0> : "
        static let startSecondGame = "턴] 묵(1), 찌(2), 빠(3)! <종료 : 0> : "
        static let inputError = "잘못된 입력입니다. 다시 시도해주세요."
    }

    enum Result {
        static let userWin = "이겼습니다!"
        static let userLose = "졌습니다!"
        static let draw = "비겼습니다!"
        static let gameEnd = "게임 종료"
    }
}

func runFirstRound() {
    let userInput: String? = printMenuForFirstGame()
    
    if userInput == Game.Finish.shutDown {
        print(Message.Result.gameEnd)
        return
    }
    
    let gameResult: Game.Result = startFirstGame(userNumber: userInput)
    printGameResultMessage(gameResult: gameResult)
    
    if gameResult == .fightAgain {
        runFirstRound()
        return
    }
    determineWhoseTurn(gameResult: gameResult)
    runSecondRound()
}

func runSecondRound() {
    let userSecondInput: String? = printMenuForSecondGame()
    
    if userSecondInput == Game.Finish.shutDown {
        print(Message.Result.gameEnd)
        return
    }
    
    let gameResult: Game.Result = startSecondGame(userNumber: userSecondInput)

    if gameResult == .fightAgain {
        runSecondRound()
        return
    }
    print(Message.Result.gameEnd)
}

func printMenuForFirstGame() -> String? {
    while true {
        print(Message.Menu.startGame, terminator: "")
        
        if let userFirstInput = receiveRightInput() {
            return userFirstInput
        } else {
            print(Message.Menu.inputError)
        }
    }
}

func printMenuForSecondGame() -> String? {
    while true {
        print("[\(whoseTurn.printedText)", Message.Menu.startSecondGame, terminator: "")
        
        if let userSecondInput = receiveRightInput() {
            return userSecondInput
        } else {
            print(Message.Menu.inputError)
            whoseTurn = .computer
        }
    }
}

func receiveRightInput() -> String? {
    let allowedInputRange = 0...3
    let userInput = readLine()
    let inputRangeVerification: Bool = (allowedInputRange.map{ String($0) }).contains(userInput)
    
    guard inputRangeVerification else { return nil }
    return userInput
}

func startFirstGame(userNumber: String?) -> Game.Result {
    let allowedNumberRange = 1...3
    let computerNumber = String(Int.random(in: allowedNumberRange))
    
    let userHand = convertNumberForFisrtGame(oneNumber: userNumber)
    let computerHand = convertNumberForFisrtGame(oneNumber: computerNumber)
    let gameResult = fightFirstGame(userHand: userHand, computerHand: computerHand)
    return gameResult
}

func startSecondGame(userNumber: String?) -> Game.Result {
    let allowedNumberRange = 1...3
    let computerNumber = String(Int.random(in: allowedNumberRange))
    
    let userHand = convertNumberForSecondGame(oneNumber: userNumber)
    let computerHand = convertNumberForSecondGame(oneNumber: computerNumber)
    let gameResult = fightSecondGame(userHand: userHand, computerHand: computerHand)
    return gameResult
}

func convertNumberForFisrtGame(oneNumber: String?) -> Hand {
    switch oneNumber {
    case "1":
        return .scissors
    case "2":
        return .rock
    case "3":
        return .paper
    default:
        return .none
    }
}

func convertNumberForSecondGame(oneNumber: String?) -> Hand {
    switch oneNumber {
    case "1":
        return .rock
    case "2":
        return .scissors
    case "3":
        return .paper
    default:
        return .none
    }
}

func fightFirstGame(userHand: Hand, computerHand: Hand) -> Game.Result {
    switch (userHand, computerHand) {
    case (.rock, .scissors), (.paper, .rock), (.scissors, .paper):
        return .userWin
    case (.scissors, .rock), (.rock, .paper), (.paper, .scissors):
        return .userLose
    default:
        return .fightAgain
    }
}

func fightSecondGame(userHand: Hand, computerHand: Hand) -> Game.Result {
    if userHand == computerHand && whoseTurn == .user {
        print("\(whoseTurn.printedText)의 승리!")
        return .userWin
    } else if userHand == computerHand && whoseTurn == .computer {
        print("\(whoseTurn.printedText)의 승리!")
        return .userLose
    } else {
        let gameResult: Game.Result = fightFirstGame(userHand: userHand, computerHand: computerHand)
        determineWhoseTurn(gameResult: gameResult)
        print("\(whoseTurn.printedText)의 턴입니다")
        return .fightAgain
    }
}

func determineWhoseTurn(gameResult: Game.Result) {
    if gameResult == .userWin {
        whoseTurn = .user
    } else if gameResult == .userLose {
        whoseTurn = .computer
    }
}

func printGameResultMessage(gameResult: Game.Result) {
    switch gameResult {
    case .userWin:
        print(Message.Result.userWin)
    case .userLose:
        print(Message.Result.userLose)
    case .fightAgain:
        print(Message.Result.draw)
    }
}

runFirstRound()
