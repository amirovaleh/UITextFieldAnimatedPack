//
//  UITextFieldAnimated+Ext+CheckStyle.swift
//  
//
//  Created by Valeh Amirov on 10.05.24.
//

import UIKit

extension UITextFieldAnimated {
    
    internal func beginEditingAnimationCheck() {
        guard let animation else { return }
        if whenToStart == .beginEditing {
            
            switch animation {
            case .betweenBorderAndTextFieldStyle:
                betweenBorderAndTextFieldBeginEditing()
            case .onBorderLineStyle:
                onBorderLineBeginEditing()
            case .overBorderLineStyle:
                overBorderLineBeginEditing()
            case .hiddenPlaceholderStyle:
                hiddenPlaceholderBeginEditing()
            }
        } else if whenToStart == .whileWriting && animation == .hiddenPlaceholderStyle {
            hiddenPlaceholderBeginEditing()
        }
    }
    
    internal func didChangeSelectionAnimationCheck(text: String) {
        guard let animation else { return }
        
        if whenToStart == .whileWriting {
            switch animation {
            case .betweenBorderAndTextFieldStyle:
                betweenBorderAndTextFieldCharacterChanged(text: text)
            case .onBorderLineStyle:
                onBorderLineCharacterChanged(text: text)
            case .overBorderLineStyle:
                overBorderLineCharacterChanged(text: text)
            case .hiddenPlaceholderStyle:
                hiddenPlaceholderCharacterChanged(text: text)
            }
        } else if whenToStart == .beginEditing && animation == .hiddenPlaceholderStyle {
            hiddenPlaceholderCharacterChanged(text: text)
        }
    }
    
    internal func endEditingAnimationCheck() {
        guard let animation else { return }
        if whenToStart == .beginEditing {
            switch animation {
            case .betweenBorderAndTextFieldStyle:
                betweenBorderAndTextFieldEndEditing()
            case .onBorderLineStyle:
                onBorderLineEndEditing()
            case .overBorderLineStyle:
                overBorderLineEndEditing()
            case .hiddenPlaceholderStyle:
                hiddenPlaceholderEndEditing()
            }
        } else if whenToStart == .whileWriting && animation == .hiddenPlaceholderStyle {
            hiddenPlaceholderEndEditing()
        }
    }
    
    internal func set(borderColor: UIColor) {
        guard let animation else { return }
        
        if animation == .onBorderLineStyle {
            textField.layer.borderColor = borderColor.cgColor
        } else {
            self.layer.borderColor = borderColor.cgColor
        }
    }
}
