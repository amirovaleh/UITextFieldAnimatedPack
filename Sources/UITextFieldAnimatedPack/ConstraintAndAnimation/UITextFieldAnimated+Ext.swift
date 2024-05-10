//
//  UITextFieldAnimated+Ext.swift
//
//
//  Created by Valeh Amirov on 10.05.24.
//

import UIKit

extension UITextFieldAnimated {
    
    internal func setDefaultConstraint() {
        
        self.addSubview(textField)
        self.addSubview(placeholderLabel)
        
        textField.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        labelLeading = placeholderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5)
        labelTrailing = placeholderLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
        labelYCenter = placeholderLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        
        selfHeight = self.heightAnchor.constraint(equalToConstant: 50)
        textFielHeight = textField.heightAnchor.constraint(equalToConstant: 50)
        
        labelLeading?.isActive = true
        labelYCenter?.isActive = true
        
        selfHeight?.isActive = true
        textFielHeight?.isActive = true
    }
}

// MARK: ---------------- TextField Style ---------------- betweenBorderAndTextFieldStyle ----------------

extension UITextFieldAnimated {

    internal func betweenBorderAndTextFieldBeginEditing() {
        let xCoordinate = -self.placeholderLabel.preferredMaxLayoutWidth * 0.15
        let yCoordinate = -self.frame.height / 4
        
        let transform1 = CGAffineTransform(scaleX: 0.7, y: 0.7)
        let transform2 = CGAffineTransform(translationX: xCoordinate, y: yCoordinate)
        
        self.textFielHeight?.constant = 40
        self.selfHeight?.constant = 60
        
        if !isPlaceholderMoved {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) {
                self.placeholderLabel.transform = CGAffineTransformConcat(transform1, transform2)
                self.textField.layoutIfNeeded()
                self.layoutIfNeeded()
            }
            self.isPlaceholderMoved = true
        }
    }
    
    internal func betweenBorderAndTextFieldEndEditing() {
        self.textFielHeight?.constant = 50
        self.selfHeight?.constant = 50
        self.isPlaceholderMoved = false
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) {
            self.placeholderLabel.transform = .identity
            self.textField.transform = .identity
            
            self.textField.layoutIfNeeded()
            self.layoutIfNeeded()
        }
    }
    
    internal func betweenBorderAndTextFieldCharacterChanged(text: String) {
        let xCoordinate = -self.placeholderLabel.preferredMaxLayoutWidth * 0.15
        let yCoordinate = -self.frame.height / 4

        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) {
            if !text.isEmpty && !self.isPlaceholderMoved {
                self.selfHeight?.constant = 60
                self.textFielHeight?.constant = 40
                let transform1 = CGAffineTransform(scaleX: 0.7, y: 0.7)
                let transform2 = CGAffineTransform(translationX: xCoordinate, y: yCoordinate)
                self.placeholderLabel.transform = CGAffineTransformConcat(transform1, transform2)
                self.isPlaceholderMoved = true
            } else if text.isEmpty && self.isPlaceholderMoved {
                self.placeholderLabel.transform = .identity
                self.selfHeight?.constant = 50
                self.textFielHeight?.constant = 50
                self.isPlaceholderMoved = false
            }
            self.textField.layoutIfNeeded()
            self.layoutIfNeeded()
        }
    }
}

// MARK: ---------------- TextField Style ---------------- overBorderLineStyle ----------------

extension UITextFieldAnimated {
    
    internal func overBorderLineBeginEditing() {
        let xCoordinate = -self.placeholderLabel.preferredMaxLayoutWidth * 0.15
        let yCoordinate = -self.frame.height / 2 - 10
        
        let transform1 = CGAffineTransform(scaleX: 0.7, y: 0.7)
        let transform2 = CGAffineTransform(translationX: xCoordinate, y: yCoordinate)

        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) {
            self.placeholderLabel.transform = CGAffineTransformConcat(transform1, transform2)
        }
    }
    
    internal func overBorderLineEndEditing() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) {
            self.placeholderLabel.transform = .identity
        }
    }
    
    internal func overBorderLineCharacterChanged(text: String) {
        let xCoordinate = -self.placeholderLabel.preferredMaxLayoutWidth * 0.15
        let yCoordinate = -self.frame.height / 2 - 10
        
        let transform1 = CGAffineTransform(scaleX: 0.7, y: 0.7)
        let transform2 = CGAffineTransform(translationX: xCoordinate, y: yCoordinate)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) {
            if !text.isEmpty {
                self.placeholderLabel.transform = CGAffineTransformConcat(transform1, transform2)
            } else if text.isEmpty {
                self.placeholderLabel.transform = .identity
            }
        }
    }
}

// MARK: ---------------- TextField Style ---------------- hiddenPlaceholderStyle ----------------

extension UITextFieldAnimated {
    
    internal func hiddenPlaceholderBeginEditing() {
        self.labelLeading?.isActive = false
        self.labelTrailing?.isActive = true
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) {
            self.layoutIfNeeded()
            self.placeholderLabel.layoutIfNeeded()
        }
    }
    
    internal func hiddenPlaceholderEndEditing() {
        self.labelLeading?.isActive = true
        self.labelTrailing?.isActive = false
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) {
            self.layoutIfNeeded()
            self.placeholderLabel.layoutIfNeeded()
        }
    }
    
    internal func hiddenPlaceholderCharacterChanged(text: String) {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) {
            if !text.isEmpty {
                self.placeholderLabel.alpha = 0
            } else if text.isEmpty  {
                self.placeholderLabel.alpha = 1
            }
            self.layoutIfNeeded()
        } completion: {_ in
            if !text.isEmpty {
                self.placeholderLabel.isHidden = true
            } else if text.isEmpty  {
                self.placeholderLabel.isHidden = false
            }
        }
    }
}

// MARK: ---------------- TextField Style ---------------- onBorderLineStyle ----------------
extension UITextFieldAnimated {
    
    internal func onBorderLineBeginEditing() {
        let xCoordinate = -self.placeholderLabel.preferredMaxLayoutWidth * 0.15
        let yCoordinate = -self.frame.height / 2
        
        let transform1 = CGAffineTransform(scaleX: 0.7, y: 0.7)
        let transform2 = CGAffineTransform(translationX: xCoordinate, y: yCoordinate)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) {
            self.placeholderLabel.backgroundColor = .white
            self.placeholderLabel.transform = CGAffineTransformConcat(transform1, transform2)
        }
    }
    
    internal func onBorderLineEndEditing() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) {
            self.placeholderLabel.transform = .identity
            self.placeholderLabel.backgroundColor = .clear
        }
    }
    
    
    internal func onBorderLineCharacterChanged(text: String) {
        let xCoordinate = -self.placeholderLabel.preferredMaxLayoutWidth * 0.15
        let yCoordinate = -self.frame.height / 2
        
        let transform1 = CGAffineTransform(scaleX: 0.7, y: 0.7)
        let transform2 = CGAffineTransform(translationX: xCoordinate, y: yCoordinate)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) {
            if !text.isEmpty {
                self.placeholderLabel.backgroundColor = .white
                self.placeholderLabel.transform = CGAffineTransformConcat(transform1, transform2)
            } else if text.isEmpty {
                self.placeholderLabel.backgroundColor = .clear
                self.placeholderLabel.transform = .identity
            }
        }
    }
}
