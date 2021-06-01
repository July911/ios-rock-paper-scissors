//
//  RockPaperScissors - main.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import Foundation

enum RockPaperScissors: Int {
	case Scissors = 1, Rock, Paper
	
	init(rawValue: Int) {
		switch rawValue {
		case 1:
			self = .Scissors
		case 2:
			self = .Rock
		case 3:
			self = .Paper
		default:
			self = .Scissors
		}
	}
}

func printMenu() {
	print("가위(1), 바위(2), 보(3)! <종료 : 0> : ", terminator: "")
}

func printWrongInput() {
	print("잘못된 입력입니다. 다시 시도해주세요.")
}

func printWinMessage() {
	print("이겼습니다!")
}

func printLoseMessage() {
	print("졌습니다!")
}

func printTieMessage() {
	print("비겼습니다!")
}

func receiveUserInput() -> Int {
	let userInput = readLine()
	
	guard let validInput = userInput else {
		return -1
	}
	
	let convertedInput = Int(validInput)
	
	guard let validConvertedInput = convertedInput else {
		return -1
	}
	
	return validConvertedInput
}

func compareRockPaperScissors(user: RockPaperScissors, oppenent: RockPaperScissors) -> String {
	let myRawValue: Int = user.rawValue - 1
	let opponentRawValue: Int = oppenent.rawValue - 1
	
	if myRawValue == opponentRawValue {
		return "Tie"
	} else if opponentRawValue == (myRawValue + 1) % 3 {
		return "Lose"
	}
	
	return "Win"
}

while true {
	printMenu()
	let randomNumber = Int.random(in: 1...3)
	let computerHand = RockPaperScissors(rawValue: randomNumber)
	var userDecision = receiveUserInput()
	
	if userDecision == 0 {
		print("게임 종료")
		break
	}
	
	while userDecision < 1 || userDecision > 3 {
		printWrongInput()
		userDecision = receiveUserInput()
	}
	
	let userHand = RockPaperScissors(rawValue: userDecision)
	
	
	switch compareRockPaperScissors(user: userHand, oppenent: computerHand) {
	case "Tie":
		printTieMessage()
	case "Lose":
		printLoseMessage()
	case "Win":
		printWinMessage()
	default: break
	}
}

