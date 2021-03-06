//
//  Nodes.swift
//  Calculator
//
//  Created by Peter Vorwieger on 01.12.16.
//  Copyright © 2016 Peter Vorwieger. All rights reserved.
//

import Foundation

 let behaviour = NSDecimalNumberHandler(roundingMode: NSDecimalNumber.RoundingMode.plain, scale: CShort(NSDecimalNoScale), raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)

public protocol ExprNode: CustomStringConvertible {
    var result:NSDecimalNumber { get }
}

public struct NumberNode: ExprNode {
    public let value: String
    public var description: String {
        return "NumberNode(\(value))"
    }
    public var result: NSDecimalNumber {
        return NSDecimalNumber(string: value)
    }
}

public struct BinaryOpNode: ExprNode {
    public let op: String
    public let lhs: ExprNode
    public let rhs: ExprNode
    public var description: String {
        return "BinaryOpNode(\(op), lhs: \(lhs), rhs: \(rhs))"
    }
    public var result: NSDecimalNumber {
        switch op {
        case "+":  return lhs.result.adding(rhs.result, withBehavior: behaviour)
        case "-":  return lhs.result.subtracting(rhs.result, withBehavior: behaviour)
        case "*":  return lhs.result.multiplying(by: rhs.result, withBehavior: behaviour)
        case "/":  return lhs.result.dividing(by: rhs.result, withBehavior: behaviour)
        default: return NSDecimalNumber()
        }
    }
}


