//
//  CustomButton.swift
//  Helicopter Panel
//
//  Created by Norman Norris on 9/23/19.
//  Copyright © 2019 Norman Norris. All rights reserved.
//

import Foundation
import UIKit

class CustomButton : UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        setTitleColor(.black, for: .normal)
        backgroundColor = .white
        layer.cornerRadius = 0
        clipsToBounds = true
        layer.masksToBounds = true
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor
    }
    
    func resetButton() {
        setTitleColor(.black, for: .normal)
        backgroundColor = .white
    }
    
    func turnButtonYellow() {
        backgroundColor = .yellow
    }
    
    func turnButtonRed() {
        setTitleColor(.white, for: .normal)
        backgroundColor = .red
    }

}
