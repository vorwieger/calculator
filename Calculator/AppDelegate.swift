//
//  AppDelegate.swift
//  Calculator
//
//  Created by Peter Vorwieger on 27.11.16.
//  Copyright © 2016 Peter Vorwieger. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSTextFieldDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var inputField: NSTextField!
    @IBOutlet weak var outputField: NSTextField!
    @IBOutlet weak var scaleField: NSTextField!
    @IBOutlet weak var scaleSlider: NSSlider!
    
    let numberFormatter = NumberFormatter()
    
    var scale:Int = 0 {
        didSet {
            scaleField.intValue = Int32(scale)
            updateFormatter()
            calculate()
        }
    }
    
    var input:String = "" {
        didSet {
            calculate()
        }
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        inputField.delegate = self
        scale = 15
    }
    
    @IBAction func scaleChanged(_ slider: NSSlider) {
        scale = Int(slider.intValue)
    }

    override func controlTextDidChange(_ notification: Notification) {
        let textField = notification.object as! NSTextField
        input = textField.stringValue
            .replacingOccurrences(of: ",", with: ".")
            .replacingOccurrences(of: "x", with: "*")
            .replacingOccurrences(of: "X", with: "*")
            .replacingOccurrences(of: "×", with: "*")
            .replacingOccurrences(of: "÷", with: "/")
        textField.stringValue = input
            .replacingOccurrences(of: ".", with: ",")
            .replacingOccurrences(of: "*", with: "×")
            .replacingOccurrences(of: "/", with: "÷")
    }
    
    func updateFormatter() {
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.maximumFractionDigits = scale
        numberFormatter.minimumFractionDigits = scale
        numberFormatter.roundingMode = .halfUp
        numberFormatter.locale = NSLocale.current
    }
    
    func calculate() {
        do {
            let calculator = Calculator(input: input)
            if let result = try calculator.calc() {
                if (result == NSDecimalNumber.notANumber) {
                    outputField.textColor = NSColor.red
                    outputField.stringValue = "Error"
                } else {
                    outputField.textColor = NSColor.black
                    outputField.stringValue = numberFormatter.string(from: result)!
                }
            } else {
                outputField.stringValue = ""
            }
        } catch {
            outputField.textColor = NSColor.red
        }
    }

}

