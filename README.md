# UITextFieldAnimatedPack


## Contents
1. [Introduction](#introduction)
2. [Installation](#installation)
3. [How To Use](#how-to-use)
4. [Properties](#properties)
5. [All properties](#all-properties)
6. [ATTENTION !!!](#attention-)
   - [`textField.becomeFirstResponder()` and `textField.resignFirstResponder()`](#textfieldbecomefirstresponder-and-textfieldresignfirstresponder)
   - [`textField.widthAnchor` and `textField.heightAnchor`](#textfieldwidthanchor-and-textfieldheightanchor)


## Introduction

### Requirement: iOS 13.0 +

There is open source custom  and animated textfields. You can use 4 animation style and 7 combination. So you can choose your animation style and when you want to start the animation. 


![Screen Recording 2024-05-09 at 20 42 51](https://github.com/amirovaleh/UITextFieldAnimatedPack/assets/97683310/d4c53c54-89d1-4023-b715-c4dc0db5d5df)


```swift
private let textField1 = UITextFieldAnimated(animation: .betweenBorderAndTextFieldStyle)
```

```swift
private let textField2 = UITextFieldAnimated(animation: .onBorderLineStyle)
```

```swift
private let textField3 = UITextFieldAnimated(animation: .overBorderLineStyle)
```

```swift
private let textField4 = UITextFieldAnimated(animation: .hiddenPlaceholderStyle)
```

## Installation

Open Your Project in Xcode
Go to File > Swift Packages > Add Package Dependencies..>
Enter the URL of the UITextFieldAnimatedPack repository. It will typically look like this:

```
https://github.com/amirovaleh/UITextFieldAnimatedPack
```
Then choose `Add Package`

## How To Use

It's very easy to use. For example, you assign a text field to a variable. While assigning, you specify which animation style you'll use here.
You can use the `textField.whenToStart` property to specify when the animation starts. If you don't set this, it will default to `textField.whenToStart = .beginEditing` .

```swift 

import UIKit
import UITextFieldAnimatedPack

class ViewController: UIViewController {

 private let textField: UITextFieldAnimated = {
        let textField = UITextFieldAnimated(animation: .betweenBorderAndTextFieldStyle)
        textField.whenToStart = .whileWriting
        textField.placeholder = "Full Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUIConstraints()
    }
        
    private func setupUIConstraints() {
        
        view.addSubview(textField)
        
        NSLayoutConstraint.activate([
        
            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 170),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        
        ])
    }
}
```


## Properties


I've made the textField in the UITextFieldAnimated class private and prepared the most commonly used properties as custom. Since some properties can exist both in UIView and UITextField objects, it's not possible to use the same name. Therefore, I added the word "custom" in front of these property names. For example, `textField.customInputView`.


### All properties


```swift
        // When you want to start
        textField.whenToStart = .beginEditing
        
        // Border Color
        textField.borderColor = .systemCyan
        
        // Standart Placeholder
        textField.placeholder = "Username"
        
        // color of placeholder
        textField.placeholderColor = .systemCyan.withAlphaComponent(0.5)
        
        // text of textField . You can use it both get and set
        textField.text = ""
        
        // standart UITextFieldDelegate
        textField.delegate = self
        
        // Standart isSecureTextEntry
        textField.isSecureTextEntry = true
        
        // Standart autocapitalizationType
        textField.autocapitalizationType = .sentences
        
        // standart clearButtonMode
        textField.clearButtonMode = .never
        
        // Standart inputAccessoryView
        textField.customInputAccessoryView = UIView()
        
        // Standart inputView
        textField.customInputView = UIView()
        
        // Standart keyboardType
        textField.keyboardType = .emailAddress
        
        // Standart textColor
        textField.textColor = .gray

```


## ATTENTION !!!

### `textField.becomeFirstResponder()` and `textField.resignFirstResponder()`

These two methods, `textField.customBecomeFirstResponder()` and `textField.customResignFirstResponder()`, perform the same function as the standard `textField.becomeFirstResponder()` and `textField.resignFirstResponder()` methods. However, their usage needs to be handled differently. Calling these methods during the assignment of values to the UITextFieldAnimated object or within methods like `override func viewDidLoad()` can cause issues for the proper functioning of the animations associated with the object. It's recommended to use these methods within the `override func viewDidAppear(_ animated: Bool)` method or other methods called after the view has been created for proper functionality.

```swift
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        textField.customBecomeFirstResponder() // DONT USE IT HERE
        textField.customResignFirstResponder() // DONT USE IT HERE
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        textField.customBecomeFirstResponder() // If necessary, you may use this here
        textField.customResignFirstResponder() // If necessary, you may use this here
    }


```

### `textField.widthAnchor` and `textField.heightAnchor` 
 Feel free to adjust width settings as needed when defining constraints or frames. However, please refrain from modifying height settings, as they are set to a standard value of 50 by default.


```swift
//            MARK: --- DONT DO THIS
            textField.heightAnchor.constraint(equalToConstant: 70)

//            MARK: --- OR THIS
            textField.frame.size.height = 70


//            MARK: --- If necessary, you may use this
            textField.widthAnchor.constraint(equalToConstant: 70)

//            MARK: --- OR THIS
            textField.frame.size.width = 70

```
