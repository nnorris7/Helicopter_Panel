//
//  PopoverViewController.swift
//  Helicopter Panel
//
//  Created by Norman Norris on 9/21/19.
//  Copyright © 2019 Norman Norris. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var procedureText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        textView.text = procedureText
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let fittedSize = textView?.sizeThatFits(UIView.layoutFittingCompressedSize) {
            preferredContentSize = CGSize(width: fittedSize.width + 30, height: fittedSize.height + 30)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
