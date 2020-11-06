//
//  TextFieldDesign.swift
//  Tipsy
//
//  Created by Abdihakin Elmi on 11/5/20.
//

import UIKit
@IBDesignable
open class TextFieldDesign: UITextField {

    func setup(){
           self.layer.backgroundColor = UIColor.secondarySystemFill.cgColor
           self.layer.borderColor = UIColor.white.cgColor
           self.layer.borderWidth = 0.0
           self.layer.cornerRadius = 15
           self.layer.masksToBounds = false
           self.layer.shadowRadius = 2.0
           self.layer.shadowColor = UIColor.gray.cgColor
           self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
           self.layer.shadowOpacity = 1.0
           self.layer.shadowRadius = 1.0
           let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
           self.leftView = paddingView
           self.leftViewMode = UITextField.ViewMode.always

   }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setup()
        }
  
    

}
