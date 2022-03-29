//
//  CustomKeyboard.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 29/03/22.
//

import UIKit

class keyboardShow: UIView {
    
    static var shared: keyboardShow {
        let instance = keyboardShow()
        return instance
    }
    
    func keyboardWillShow(sender: NSNotification) -> CGFloat {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? CustomTexField else { return 0 }
        
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertStackViewFrame = self.convert(currentTextField.frame, from: currentTextField.superview)
        let stackViewBottomY = convertStackViewFrame.origin.y + 110

        if stackViewBottomY > keyboardTopY {
            let stackBoxY = convertStackViewFrame.origin.y
            let newFrameY = (stackBoxY - keyboardTopY / 2) * -1
            return newFrameY
        }
        
        return 0
    }
    
    func keyboardWillHide(notification: NSNotification) -> CGFloat {
        return 0
    }
}
