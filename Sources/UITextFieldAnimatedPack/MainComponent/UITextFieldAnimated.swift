//
//  UITextFieldAnimated.swift
//  
//
//  Created by Valeh Amirov on 10.05.24.
//

import UIKit

open class UITextFieldAnimated: UIView {
        
    internal var labelLeading: NSLayoutConstraint?
    internal var labelYCenter: NSLayoutConstraint?
    internal var labelTrailing: NSLayoutConstraint?
    internal var selfHeight: NSLayoutConstraint?
    internal var textFielHeight: NSLayoutConstraint?
    
    internal var isPlaceholderMoved: Bool = false
    internal var animation: TextFieldStyle?
    
    private var isSecure: Bool = false
    private var placheholderText: String?
    private var textFieldkeyboardType: UIKeyboardType = .default
    private var autocapitalizationTypeOfTextField: UITextAutocapitalizationType = .none
    private var colorOfText: UIColor?
    private var colorOfPlaceholder: UIColor?
    private var inputAccessoryViewOfTextField: UIView?
    private var inputViewOfTextField: UIView?
    private var clearButtonModeOfTextField: UITextField.ViewMode = .never
    private var customDelegate: UITextFieldDelegate?
    
    open var whenToStart: WhenOptions = .beginEditing
    
    open var text: String? {
        didSet {
            guard let text else { return }
            textField.text = text
        }
    }
    
    open var placeholder: String? {
        get {
            return placheholderText
        }
        set {
            placheholderText = newValue
            placeholderLabel.text = newValue
        }
    }
    
    open var borderColor: UIColor? {
        didSet {
            guard let borderColor else { return }
            set(borderColor: borderColor)
        }
    }
    
    
    open var placeholderColor: UIColor?  {
        get {
            return colorOfPlaceholder
        }
        set {
            colorOfPlaceholder = newValue
            placeholderLabel.textColor = newValue
        }
    }
    
    open var textColor: UIColor? {
        get {
            return colorOfText
        }
        set {
            colorOfText = newValue
            textField.textColor = newValue
        }
    }
    
    open var isSecureTextEntry: Bool {
        get {
            return isSecure
        }
        set {
            isSecure = newValue
            textField.isSecureTextEntry = newValue
        }
    }
    
    open var customInputView: UIView? {
        get {
            return inputViewOfTextField
        }
        set {
            inputViewOfTextField = newValue
            textField.inputView = newValue
        }
    }
    
    open var customInputAccessoryView: UIView? {
        get {
            return inputAccessoryViewOfTextField
        }
        set {
            inputAccessoryViewOfTextField = newValue
            textField.inputAccessoryView = newValue
        }
    }
    
    open var keyboardType: UIKeyboardType {
        get {
            return textFieldkeyboardType
        }
        set {
            textFieldkeyboardType = newValue
            textField.keyboardType = newValue
        }
    }
    
    open var autocapitalizationType: UITextAutocapitalizationType {
        get {
            return autocapitalizationTypeOfTextField
        }
        set {
            autocapitalizationTypeOfTextField = newValue
            textField.autocapitalizationType = newValue
        }
    }
    
    open var clearButtonMode: UITextField.ViewMode {
        get {
            return clearButtonModeOfTextField
        }
        set {
            clearButtonModeOfTextField = newValue
            textField.clearButtonMode = newValue
        }
    }
    
    open weak var delegate: UITextFieldDelegate? {
        get {
            return customDelegate
        }
        set {
            customDelegate = newValue
            textField.delegate = newValue
        }
    }
    
    internal lazy var textField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = autocapitalizationType
        let view = UIView()
        view.widthAnchor.constraint(equalToConstant: 10).isActive = true
        textField.leftView = view
        textField.leftViewMode = .always
        textField.addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
        textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    internal let placeholderLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.textColor = .gray.withAlphaComponent(0.5)
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public init(animation: TextFieldStyle) {
        super.init(frame: CGRect())
        self.animation = animation
        setDefaultConstraint()
        setBorder()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setBorder() {
        guard let animation else { return }
        
        if animation == .onBorderLineStyle {
            textField.layer.borderColor = UIColor.gray.cgColor
            textField.layer.cornerRadius = 10
            textField.layer.borderWidth = 1
        } else {
            self.layer.borderColor = UIColor.gray.cgColor
            self.layer.cornerRadius = 10
            self.layer.borderWidth = 1
        }
    }
    
    @objc private func editingDidBegin(_ textField: UITextField) {
        beginEditingAnimationCheck()
    }
    
    @objc private func editingDidEnd(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if text.isEmpty {
            endEditingAnimationCheck()
        }
    }
    
    @objc private func editingChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        didChangeSelectionAnimationCheck(text: text)
        self.text = text
    }
}

extension UITextFieldAnimated {
    
    public func customBecomeFirstResponder() {
        textField.becomeFirstResponder()
    }
    
    public func customResignFirstResponder() {
        textField.resignFirstResponder()
    }
}
