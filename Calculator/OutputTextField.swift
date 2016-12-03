//
//  OutputTextField.swift
//  Calculator
//
//  Created by Peter Vorwieger on 03.12.16.
//  Copyright © 2016 Peter Vorwieger. All rights reserved.
//

import Cocoa

class OutputTextField: NSTextField {

    override func draw(_ dirtyRect: NSRect) {
        let size = calculateFontSize(self.bounds.size)
        self.font = NSFont.systemFont(ofSize: size)
        super.draw(dirtyRect)
    }

    func defaultFont(_ fontSize:CGFloat) -> NSFont {
        return NSFont.systemFont(ofSize: fontSize)
    }

    func attributes(_ fontSize:CGFloat) -> [String:AnyObject] {
        let font = defaultFont(fontSize)
        let color = NSColor.white
        let style = NSMutableParagraphStyle()
        style.lineBreakMode = NSLineBreakMode.byWordWrapping
        return [
            NSFontAttributeName: font,
            NSForegroundColorAttributeName: color,
            NSParagraphStyleAttributeName: style
        ]
    }
    
    func boudingSize(_ size: NSSize, fontSize _fontSize:CGFloat) -> NSSize {
        let attr = attributes(_fontSize)
        let options = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect = (stringValue as NSString).boundingRect(with: size,
                                                   options: options, attributes: attr)
        return rect.size
    }
    
    func calculateFontSize(_ size: NSSize) -> CGFloat {
        let _fontSize:CGFloat = 36
        let bounds = boudingSize(size, fontSize: _fontSize)
        let scale = min(size.width / bounds.width, size.height / bounds.height)
        return floor(max(scale * _fontSize, _fontSize)) - 5.0
    }
    
}
