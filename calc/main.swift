//
//  main.swift
//  calc
//
//  Created by Aryan Nateghnia on 7/4/19.
//  Copyright © 2019 UTS. All rights reserved.
//

import Foundation

var args = ProcessInfo.processInfo.arguments
args.removeFirst() // remove the name of the program

var calculation: [String] = args

// Mathematical Operation Processes:

func processExponents(_ index: Int) -> [Int] {
    var leftNum: String = "" // leftNum contains the value to the left of the operator.
    var rightNum: String = "" // rightNum contains the value to the right of the operator.
    var indexesOfNum: [Int] = [] // An array containing the indexes of the operator/numbers that were solved and need to be deleted later on.
    if calculation[index] == "^" {
        leftNum = calculation[index-1]
        rightNum = calculation[index+1]
        indexesOfNum.append(index)
        indexesOfNum.append(index+1) // Add the indexes of the operator and number to the right of the operator for later deletion.
    }
    var FinalDouble = pow(Double(leftNum)!, Double(rightNum)!) // Pow() doesn't work on Ints, so we must use double.
    var finalInt = Int(FinalDouble)
    calculation[index-1] = String(finalInt) // Set the left-most number of our calculation to the resultant of the mathematical operation.
    return indexesOfNum
}

func processModulus(_ index: Int) -> [Int] {
    var leftNum: String = "" // leftNum contains the value to the left of the operator.
    var rightNum: String = "" // rightNum contains the value to the right of the operator.
    var indexesOfNum: [Int] = [] // An array containing the indexes of the operator/numbers that were solved and need to be deleted later on.
    if calculation[index] == "%" {
        leftNum = calculation[index-1]
        rightNum = calculation[index+1]
        indexesOfNum.append(index)
        indexesOfNum.append(index+1) // Add the indexes of the operator and number to the right of the operator for later deletion.
    }
    let final = Int(leftNum)! % Int(rightNum)!
    calculation[index-1] = String(final) // Set the left-most number of our calculation to the resultant of the mathematical operation.
    return indexesOfNum
}

func processMultiplication(_ index: Int) -> [Int] {
    var leftNum: String = "" // leftNum contains the value to the left of the operator.
    var rightNum: String = "" // rightNum contains the value to the right of the operator.
    var indexesOfNum: [Int] = [] // An array containing the indexes of the operator/numbers that were solved and need to be deleted later on.
    if calculation[index] == "x" {
        leftNum = calculation[index-1]
        rightNum = calculation[index+1]
        indexesOfNum.append(index)
        indexesOfNum.append(index+1) // Add the indexes of the operator and number to the right of the operator for later deletion.
    }
    let final = Int(leftNum)! * Int(rightNum)!
    calculation[index-1] = String(final) // Set the left-most number of our calculation to the resultant of the mathematical operation.
    return indexesOfNum
}

func processDivision(_ index: Int) -> [Int] {
    var leftNum: String = "" // leftNum contains the value to the left of the operator.
    var rightNum: String = "" // rightNum contains the value to the right of the operator.
    var indexesOfNum: [Int] = [] // An array containing the indexes of the operator/numbers that were solved and need to be deleted later on.
    if calculation[index] == "/" {
        leftNum = calculation[index-1]
        rightNum = calculation[index+1]
        indexesOfNum.append(index)
        indexesOfNum.append(index+1) // Add the indexes of the operator and number to the right of the operator for later deletion.
    }
    let final = Int(leftNum)! / Int(rightNum)!
    calculation[index-1] = String(final) // Set the left-most number of our calculation to the resultant of the mathematical operation.
    return indexesOfNum
}

func processAddition(_ index: Int) -> [Int] {
    var leftNum: String = "" // leftNum contains the value to the left of the operator.
    var rightNum: String = "" // rightNum contains the value to the right of the operator.
    var indexesOfNum: [Int] = [] // An array containing the indexes of the operator/numbers that were solved and need to be deleted later on.
    if calculation[index] == "+" {
        leftNum = calculation[index-1]
        rightNum = calculation[index+1]
        indexesOfNum.append(index)
        indexesOfNum.append(index+1) // Add the indexes of the operator and number to the right of the operator for later deletion.
    }
    let final = Int(leftNum)! + Int(rightNum)!
    calculation[index-1] = String(final) // Set the left-most number of our calculation to the resultant of the mathematical operation.
    return indexesOfNum
}

func processSubtraction(_ index: Int) -> [Int] {
    var leftNum: String = "" // leftNum contains the value to the left of the operator.
    var rightNum: String = "" // rightNum contains the value to the right of the operator.
    var indexesOfNum: [Int] = [] // An array containing the indexes of the operator/numbers that were solved and need to be deleted later on.
    if calculation[index] == "-" {
        leftNum = calculation[index-1]
        rightNum = calculation[index+1]
        indexesOfNum.append(index)
        indexesOfNum.append(index+1) // Add the indexes of the operator and number to the right of the operator for later deletion.
    }
    let final = Int(leftNum)! - Int(rightNum)!
    calculation[index-1] = String(final) // Set the left-most number of our calculation to the resultant of the mathematical operation.
    return indexesOfNum
}

// Functions for modifying, cleaning and solving the calculation:

func removeSolvedElements(_ indexesOfNum: [Int]) {
    for i in 0..<indexesOfNum.count {
       calculation[indexesOfNum[i]] = "" //Solved elements become ""
    }
    delEmptyElements()
}

func delEmptyElements() {
    let noEmptyElements = calculation.filter { $0.isEmpty == false }
    calculation = noEmptyElements // Replace the 'calculation' array with one which doesn't contain any empty ("") elements.
}

func cleanCalc() { // Clean and filter out any errors such as double pluses (++) in the calculation.
    var indexesOfNum: [Int] = [] // An array containing the indexes of the operator/numbers that were solved and need to be deleted later on.
    for i in 0..<calculation.count { // Check for double-plus' (eg. 23++12)
        if calculation[i] == "+" {
            if calculation[i+1] == "+" {
                indexesOfNum.append(i)
            }
        }
    }
    
    for i in 0..<calculation.count { // Check if any elements in the calculation contain a plus (eg. +12 + 40)
        if calculation[i].contains("+") {
            let decimalRange = calculation[i].rangeOfCharacter(from: CharacterSet.decimalDigits)
            if decimalRange != nil {
                calculation[i] = calculation[i].replacingOccurrences(of: "+", with: "")
            }
        }
    }
    
    if calculation[0] == "+" { //Check if the calculation begins with a + (eg. + 45 + 30)
        indexesOfNum.append(0)
    }
    
    for i in 0..<calculation.count { // Check for double-minus' (eg. 11--19)
        if calculation[i] == "-" {
            if calculation[i+1] == "-" { // Replace the left-most '-' with a plus, and remove the minus on the right.
                indexesOfNum.append(i+1)
                calculation[i] = "+"
            }
        }
    }
    removeSolvedElements(indexesOfNum)
}

func solveCalc() { // Function for figuring out which operator to solve first.
    var i = 0
    var x = 100 // Used to give the left-most operators a higher value.
    var opIndexesDict: [Int: Int] = [:] // Stores the operators and their indexes that may be used in processCalc(), taking into account the operation of order.
    var opIndex: Int = 0 // Stores the operator that will be used in processCalc(), in correct BODMAS-enforced order.
    while i < calculation.count { // We use a while loop, as opposed to a for loop, because a while  loop can handle dynamic conditions (calculation.count)
        if calculation[i] == "^" {
            opIndexesDict.updateValue(5+x, forKey: i)
        } else if calculation[i] == "%" {
            opIndexesDict.updateValue(3+x, forKey: i)
        } else if calculation[i] == "x" {
            opIndexesDict.updateValue(3+x, forKey: i)
        } else if calculation[i] == "/" {
            opIndexesDict.updateValue(3+x, forKey: i)
        } else if calculation[i] == "+" {
            opIndexesDict.updateValue(1+x, forKey: i)
        } else if calculation[i] == "-" {
            opIndexesDict.updateValue(1+x, forKey: i)
        }
        i += 1
        x -= 1
    }
    opIndex = opIndexesDict.max {a, b in a.value < b.value}?.key ?? 0 // Find key of the the operator with the highest value.
    processCalc(opIndex)
}

func processCalc(_ opIndex: Int) { // Function that accepts an index of an operator from our calculation, matches it with an appropriate operator case, and then solves the calculation.
    switch (calculation[opIndex]) {
    case "^": let indexesOfNum = processExponents(opIndex); removeSolvedElements(indexesOfNum)
    case "%": let indexesOfNum = processModulus(opIndex); removeSolvedElements(indexesOfNum)
    case "x": let indexesOfNum = processMultiplication(opIndex); removeSolvedElements(indexesOfNum)
    case "/": let indexesOfNum = processDivision(opIndex); removeSolvedElements(indexesOfNum)
    case "+": let indexesOfNum = processAddition(opIndex); removeSolvedElements(indexesOfNum)
    case "-": let indexesOfNum = processSubtraction(opIndex); removeSolvedElements(indexesOfNum)
    default: break
    }
}

// Main routine:

cleanCalc()
while calculation.count >= 2 {
    solveCalc()
}

print(calculation[0])
exit(0)
