//
//  ViewController.swift
//  Helicopter Panel
//
//  Created by Norman Norris on 9/21/19.
//  Copyright © 2019 Norman Norris. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet var buttons: [CustomButton]!
    @IBOutlet weak var bgImageView: UIImageView!
    
    var panelButtons = [PanelButton]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadJSON()
        
        for index in buttons.indices {
            let button = buttons[index]
            let title = panelButtons[index]
            button.setTitle(title.name, for: .normal)
            button.tag = panelButtons[index].id
        }
    }
    
    func loadJSON() {
        if let path = Bundle.main.url(forResource: "panel", withExtension: "json") {
            do {
                let data = try Data(contentsOf: path, options: .mappedIfSafe)
                let decoder = JSONDecoder()

                do {
                    panelButtons = try decoder.decode([PanelButton].self, from: data)
//                    for button in panelButtons {
//                        button.printButton()
//                    }
                } catch {
                    print(error.localizedDescription)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func hideBackground(_ sender: UIButton) {
        if sender.titleLabel?.text == "Hide Background" {
            bgImageView.isHidden = true
            sender.setTitle("Show Background", for: .normal)
        } else {
            bgImageView.isHidden = false
            sender.setTitle("Hide Background", for: .normal)
        }
    }
    
    @IBAction func showProcedure(_ sender: UIButton) {
        guard let popVC = storyboard?.instantiateViewController(withIdentifier: "popVC") as? PopoverViewController else { return }
        
        let index = sender.tag
        popVC.procedureText = panelButtons[index].procedure
        
        popVC.modalPresentationStyle = .popover

        let popOverVC = popVC.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = sender

        self.present(popVC, animated: true)

    }
}

