//
//  CustomTextField.swift
//  Retext
//
//  Created by Abraham Estrada on 6/1/21.
//

import UIKit

class CustomTextField: UITextField {
    
    init(placeholder: String) {
        super.init(frame: .zero)
        
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        leftView = spacer
        leftViewMode = .always
        
        tintColor = TINTCOLOR
        layer.cornerRadius = 12
        textColor = .black
        autocapitalizationType = .none
        spellCheckingType = .no
        borderStyle = .none
        keyboardAppearance = .dark
        backgroundColor = BACKGROUNDCOLOR
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
